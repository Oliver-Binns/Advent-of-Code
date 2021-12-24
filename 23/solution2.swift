import Foundation

try print("""
Day 23:
Sample Answer: (solve(filename: "sample2.input"))
Solution Answer: \(solve(filename: "solution2.input"))

Extension Task:
Sample Answer: \(solveExtension(filename: "sample2.input"))
Solution Answer: \(solveExtension(filename: "solution.input"))
""")

// MARK: - Parse input into data structure

func openFile(filename: String) throws -> String {
    let cwd = FileManager.default.currentDirectoryPath
    return try String(contentsOfFile: "\(cwd)/\(filename)", encoding: .utf8)
        .trimmingCharacters(in: .whitespacesAndNewlines)
}

func parseInput(_ input: String) -> [[Space]] {
    input
        .components(separatedBy: "\n")
        .map { $0.compactMap(Space.init) }
}

// MARK: - Data Structure

enum Amphipod: Character {
    case amber = "A"
    case bronze = "B"
    case copper = "C"
    case desert = "D"
}

extension Amphipod {
    var energy: Int {
        switch self {
        case .amber: return 1
        case .bronze: return 10
        case .copper: return 100
        case .desert: return 1000
        }
    }
}

enum Space: Equatable {
    case amphipod(Amphipod)
    case empty
    case wall
}
extension Space {
    init?(rawValue: Character) {
        switch rawValue {
        case "A", "B", "C", "D":
            if let amphipod = Amphipod(rawValue: rawValue) {
                self = .amphipod(amphipod)
            } else {
                return nil
            }
        case ".": self = .empty
        default: self = .wall
        }
    }

    var isAmphipod: Bool {
        switch self {
        case .amphipod: return true
        default: return false
        }
    }
}
extension Space: CustomStringConvertible {
    var description: String {
        switch self {
        case .empty:
            return "."
        case .wall:
            return "#"
        case .amphipod(let amphipod):
            return String(amphipod.rawValue)
        }
    }
}

struct Coordinate {
    let x: Int
    let y: Int
}

func makeRange(_ start: Int, _ end: Int) -> Slice<ClosedRange<Int>> {
    start < end ? (start...end).dropFirst(1) : (end...start).dropLast(1)
}

struct Move {
    let origin: Coordinate
    let destination: Coordinate

    var cost: Int {
        travelsThrough.count
    }

    var travelsThrough: [Coordinate] {
        makeRange(origin.y, destination.y).map { Coordinate(x: origin.x, y: $0) }
        + makeRange(destination.x, origin.x).map { Coordinate(x: $0, y: destination.y) }
    }

    func canTravel(onMap map: [[Space]]) -> Bool {
        !map[destination.y][destination.x].isAmphipod &&
            map[origin.y][origin.x].isAmphipod
    }

    func canTravelBackwards(onMap map: [[Space]]) -> Bool {
        map[destination.y][destination.x].isAmphipod &&
            !map[origin.y][origin.x].isAmphipod &&
            isCorrectAmphipod(onMap: map)
    }

    func isCorrectAmphipod(amphipod: Amphipod, for space: Coordinate) -> Bool {
        // if this is origin.y == 2, also check origin.y == 3 is correct
        switch amphipod {
        case .amber:
            return space.x == 3
        case .bronze:
            return space.x == 5
        case .copper:
            return space.x == 7
        case .desert:
            return space.x == 9
        }
    }

    func isCorrectAmphipod(onMap map: [[Space]]) -> Bool {
        guard case .amphipod(let amphipod) = map[destination.y][destination.x] else {
            return false
        }
        if origin.y == 5 {
            // can only travel backwards if the correct amphipod is moving into the room!
            return isCorrectAmphipod(amphipod: amphipod, for: origin)
        } else if case .amphipod(let baseAmphipod) = map[origin.y + 1][origin.x] {
            // if origin is 2, also check that the underlying amphipod is correct
            return isCorrectAmphipod(amphipod: amphipod, for: origin) &&
                isCorrectAmphipod(amphipod: baseAmphipod,
                                  for: .init(x: origin.x, y: origin.y + 1))
        } else {
            return false
        }
    }

    func isBlocked(onMap map: [[Space]]) -> Bool {
        travelsThrough
            .map { map[$0.y][$0.x] }
            .contains(where: { $0.isAmphipod })
    }
}

struct Burrow {
    let spaces: [[Space]]
    let cost: Int

    var moves: [Move] {
        hallwayPositions.flatMap { hallway in
            remainingRoomPositions.flatMap {
                $0.map { room in
                    Move(origin: room, destination: hallway)
                }
            }
        }
    }

    var validMoves: [Move] {
        moves
            .filter { !$0.isBlocked(onMap: spaces) }
            .filter { $0.canTravel(onMap: spaces) || $0.canTravelBackwards(onMap: spaces) }
    }

    var hallwayPositions: [Coordinate] {
        [1, 2, 4, 6, 8, 10, 11]
           .map { .init(x: $0, y: 1) }
    }

    var remainingRoomPositions: [[Coordinate]] {
        roomPositions.map { room in
            room.reversed().enumerated().reduce([Coordinate]()) { positions, nextPosition in
                guard positions.isEmpty else {
                    // if the previous section is wrong, this position remains to be completed
                    return positions + [nextPosition.1]
                }
                // else: only allow removal, if it's incorrect
                switch spaces[nextPosition.1.y][nextPosition.1.x] {
                case .amphipod(.amber) where nextPosition.1.x == 3:
                    return positions
                case .amphipod(.bronze) where nextPosition.1.x == 5:
                    return positions
                case .amphipod(.copper) where nextPosition.1.x == 7:
                    return positions
                case .amphipod(.desert) where nextPosition.1.x == 9:
                    return positions
                default:
                    return positions + [nextPosition.1]
                }
            }
        }
    }

    var roomPositions: [[Coordinate]] {
        [
            [.init(x: 3, y: 2), .init(x: 3, y: 3), .init(x: 3, y: 4), .init(x: 3, y: 5)],
            [.init(x: 5, y: 2), .init(x: 5, y: 3), .init(x: 5, y: 4), .init(x: 5, y: 5)],
            [.init(x: 7, y: 2), .init(x: 7, y: 3), .init(x: 7, y: 4), .init(x: 7, y: 5)],
            [.init(x: 9, y: 2), .init(x: 9, y: 3), .init(x: 9, y: 4), .init(x: 9, y: 5)],
        ]
    }

    var rooms: [[Space]] {
        roomPositions.map {
            $0.map { spaces[$0.y][$0.x] }
        }
    }

    var emptyRooms: Int {
        rooms.map { $0.filter { $0.isAmphipod }.isEmpty }.filter { $0 }.count
    }

    var inHallway: Int {
        spaces[1].filter { $0.isAmphipod }.count
    }

    var isBlocked: Bool {
        validMoves.isEmpty
    }

    var correctSlots: Int {
        roomPositions.count - remainingRoomPositions.map { $0.count }.reduce(0, +)
    }

    var isComplete: Bool {
        inHallway == 0
        && rooms[0].allSatisfy { $0 == .amphipod(.amber) }
        && rooms[1].allSatisfy { $0 == .amphipod(.bronze) }
        && rooms[2].allSatisfy { $0 == .amphipod(.copper) }
        && rooms[3].allSatisfy { $0 == .amphipod(.desert) }
    }

    init(spaces: [[Space]], cost: Int = 0) {
        self.spaces = spaces
        self.cost = cost
    }

    func sort() -> [Burrow] {
        guard !isComplete else { return [self] }
        return validMoves.map {
            var newSpaces = spaces
            newSpaces[$0.destination.y][$0.destination.x] = spaces[$0.origin.y][$0.origin.x]
            newSpaces[$0.origin.y][$0.origin.x] = spaces[$0.destination.y][$0.destination.x]

            let costPerSquare: Int
            if case .amphipod(let amphipod) = spaces[$0.origin.y][$0.origin.x] {
                costPerSquare = amphipod.energy
            } else if case .amphipod(let amphipod) = spaces[$0.destination.y][$0.destination.x] {
                costPerSquare = amphipod.energy
            } else {
                fatalError("Must have moved an amphipod")
            }

            return Self(spaces: newSpaces, cost: cost + $0.cost * costPerSquare)
        }
    }
}
extension Burrow: CustomStringConvertible {
    var description: String {
        spaces
            .map { $0.map { $0.description }.joined() }
            .joined(separator: "\n")
    }
}

// MARK: - Challenge 1 Solution

func solve(filename: String) throws -> Int {
    let input = try openFile(filename: filename)
    var smallest: Int = 47191

    var moves: [String: Int] = [input: 0]

    while !moves.keys.isEmpty {
        print(moves.keys.count)

        let afterMove = moves
            .map { Burrow(spaces: parseInput($0.key), cost: $0.value) }
            .flatMap { $0.sort() }

        let sorted = afterMove.sorted(by: { $0.correctSlots < $1.correctSlots })
        print("correct", sorted.last!.correctSlots)
        print(sorted.last!)

        if let minCost = afterMove.filter({ $0.isComplete }).map({ $0.cost }).min() {
            print("new min cost", minCost)
            smallest = min(smallest, minCost)
        }

        moves = afterMove
            .filter { $0.cost < smallest }
            .filter { !$0.isComplete }
            .map { ($0.description, $0.cost) }
            .reduce(into: [String: Int]()) { dictionary, nextValue in
                guard let cost = dictionary[nextValue.0] else {
                    dictionary[nextValue.0] = nextValue.1
                    return
                }
                dictionary[nextValue.0] = min(cost, nextValue.1)
            }
    }

    return smallest
}

// MARK: - Challenge 2 Solution
func solveExtension(filename: String) throws -> Int {
    0
}
