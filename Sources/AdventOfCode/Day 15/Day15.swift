struct Day15: Solution {
    static let day = 15

    let map: Grid<FactoryContents>
    let moves: [Move]

    init(input: String) {
        let components = input.components(separatedBy: "\n\n")
        map = Grid(
            string: components[0],
            mapping: FactoryContents.init
        )

        moves = components[1].compactMap(Move.init)
    }
    
    func calculatePartOne() -> Int {
        let finalState = makeMoves(moves, on: map)
        return calculateGPSCoodinates(for: finalState)
    }
    
    func calculatePartTwo() -> Int {
        0
    }

    func makeMoves(
        _ moves: [Move],
        on grid: Grid<FactoryContents>
    ) -> Grid<FactoryContents> {
        moves.reduce(map) { makeMove($1, grid: $0) }
    }

    func makeMove(_ move: Move, grid: Grid<FactoryContents>) -> Grid<FactoryContents> {
        guard let position = grid.findPositions(of: .robot).first else {
            preconditionFailure("Could not find position of robot")
        }

        let direction = move.direction
        var updatedMap = grid.values

        let newPosition = position.move(in: direction)

        switch updatedMap[newPosition.y][newPosition.x] {
        case .wall:
            // cannot move into wall
            break
        case .empty:
            // move robot here!
            updatedMap[newPosition.y][newPosition.x] = .robot
            updatedMap[position.y][position.x] = .empty
        case .robot:
            preconditionFailure("there should be only one robot!")
        case .box:
            var boxPosition = newPosition

            // if we find a wall, there is nothing we can do
            while updatedMap[boxPosition.y][boxPosition.x] != .wall {
                defer {
                    // iterate:
                    boxPosition = boxPosition.move(in: direction)
                }

                switch updatedMap[boxPosition.y][boxPosition.x] {
                case .wall: break
                case .box: continue // keep going until we find empty space or wall
                case .empty:
                    // move the box here..
                    updatedMap[boxPosition.y][boxPosition.x] = .box
                    // and the robot to where the box started!
                    updatedMap[newPosition.y][newPosition.x] = .robot
                    updatedMap[position.y][position.x] = .empty
                    return Grid(values: updatedMap)
                case .robot: preconditionFailure("there should be only one robot!")
                }

            }
        }

        return Grid(values: updatedMap)
    }

    func calculateGPSCoodinates(for grid: Grid<FactoryContents>) -> Int {
        let boxes = grid.findPositions(of: .box)

        return boxes
            .map { 100 * $0.y + $0.x }
            .reduce(0, +)
    }
}

enum FactoryContents: Character {
    case robot = "@"
    case box = "O"
    case wall = "#"
    case empty = "."
}
extension FactoryContents: CustomStringConvertible {
    var description: String { String(rawValue) }
}

enum Move: Character {
    case up = "^"
    case right = ">"
    case left = "<"
    case down = "v"
}

extension Move {
    var direction: Direction {
        switch self {
        case .up: return .north
        case .right: return .east
        case .down: return .south
        case .left: return .west
        }
    }
}
