import Foundation

let sample = try retrieveMatchedScanners(filename: "sample.input")
let puzzle = try retrieveMatchedScanners(filename: "solution.input")

try print("""
Day 19:
Sample Answer: \(solve(scanners: sample))
Solution Answer: \(solve(scanners: puzzle))

Extension Task:
Sample Answer: \(solveExtension(scanners: sample))
Solution Answer: \(solveExtension(scanners: puzzle))
""")

// MARK: - Parse input into data structure

func openFile(filename: String) throws -> String {
    let cwd = FileManager.default.currentDirectoryPath
    return try String(contentsOfFile: "\(cwd)/\(filename)", encoding: .utf8)
        .trimmingCharacters(in: .whitespacesAndNewlines)
}

func reduce(input: String) -> [Scanner] {
    input
        .components(separatedBy: "\n")
        .filter { !$0.isEmpty }
        .reduce(into: []) { scanners, nextLine in
            guard !nextLine.starts(with: "---") else {
                scanners.append(.init())
                return
            }
            let position = nextLine
                .components(separatedBy: ",")
                .compactMap(Int.init)

            let newBeacon = Position(x: position[0], y: position[1], z: position[2])
            scanners[scanners.count - 1].beacons.insert(newBeacon)
    }
}

// MARK: - Data Structure

struct Position: Equatable, Hashable {
    let x: Int
    let y: Int
    let z: Int
}
extension Position: CustomStringConvertible {
    var description: String { "(\(x),\(y),\(z))" }
}
extension Position {
    var possibleOrientations: [Position] {
        [
            Position(x: x, y: y, z: z),
            Position(x: -x, y: y, z: z),
            Position(x: -x, y: -y, z: z),
            Position(x: -x, y: y, z: -z),
            Position(x: -x, y: -y, z: -z),
            Position(x: x, y: -y, z: z),
            Position(x: x, y: -y, z: -z),
            Position(x: x, y: y, z: -z),

            Position(x: x, y: z, z: y),
            Position(x: -x, y: z, z: y),
            Position(x: -x, y: -z, z: y),
            Position(x: -x, y: z, z: -y),
            Position(x: -x, y: -z, z: -y),
            Position(x: x, y: -z, z: y),
            Position(x: x, y: -z, z: -y),
            Position(x: x, y: z, z: -y),

            Position(x: z, y: y, z: x),
            Position(x: -z, y: y, z: x),
            Position(x: -z, y: -y, z: x),
            Position(x: -z, y: y, z: -x),
            Position(x: -z, y: -y, z: -x),
            Position(x: z, y: -y, z: x),
            Position(x: z, y: -y, z: -x),
            Position(x: z, y: y, z: -x),

            Position(x: y, y: x, z: z),
            Position(x: -y, y: x, z: z),
            Position(x: -y, y: -x, z: z),
            Position(x: -y, y: x, z: -z),
            Position(x: -y, y: -x, z: -z),
            Position(x: y, y: -x, z: z),
            Position(x: y, y: -x, z: -z),
            Position(x: y, y: x, z: -z),

            Position(x: z, y: x, z: y),
            Position(x: -z, y: x, z: y),
            Position(x: -z, y: -x, z: y),
            Position(x: -z, y: x, z: -y),
            Position(x: -z, y: -x, z: -y),
            Position(x: z, y: -x, z: y),
            Position(x: z, y: -x, z: -y),
            Position(x: z, y: x, z: -y),

            Position(x: y, y: z, z: x),
            Position(x: -y, y: z, z: x),
            Position(x: -y, y: -z, z: x),
            Position(x: -y, y: z, z: -x),
            Position(x: -y, y: -z, z: -x),
            Position(x: y, y: -z, z: x),
            Position(x: y, y: -z, z: -x),
            Position(x: y, y: z, z: -x)
        ]
    }
}
extension Position {
    static func +(lhs: Position, rhs: Position) -> Position {
        .init(x: lhs.x + rhs.x, y: lhs.y + rhs.y, z: lhs.z + rhs.z)
    }

    static func -(lhs: Position, rhs: Position) -> Position {
        .init(x: lhs.x - rhs.x, y: lhs.y - rhs.y, z: lhs.z - rhs.z)
    }

    static func manhattanDistance(_ a: Position, b: Position) -> Int {
        let total = a - b
        return abs(total.x) + abs(total.y) + abs(total.z)
    }
}

struct Scanner {
    let position: Position
    let orientation: Int

    var beacons: Set<Position> {
        didSet {
            transformedBeacons = calculateTransformedBeacons()
        }
    }

    private(set) var transformedBeacons: Set<Position>

    init(position: Position = .init(x: 0, y: 0, z: 0),
         orientation: Int = 0,
         beacons: Set<Position> = .init()) {
        self.position = position
        self.orientation = orientation
        self.beacons = beacons
        self.transformedBeacons = .init()
        self.transformedBeacons = calculateTransformedBeacons()
        
    }

    private func calculateTransformedBeacons() -> Set<Position> {
        Set(beacons
                .map { $0.possibleOrientations[orientation] }
                .map { $0 + position })
    }

    func attemptToMatch(with otherScanner: Scanner) -> Scanner? {
        for beacon in transformedBeacons {
            for transformation in 0..<beacon.possibleOrientations.count {
                for otherBeacon in otherScanner.beacons {
                    // Attempt to Match Pairs: Calculate Offset Between Two Beacons
                    let position = (beacon - otherBeacon.possibleOrientations[transformation])

                    let scanner = Scanner(position: position,
                                          orientation: transformation,
                                          beacons: otherScanner.beacons)

                    guard intersection(scanner) >= 12 else { continue }

                    return scanner
                }
            }
        }
        return nil
    }

    func intersection(_ scanner: Scanner) -> Int {
        transformedBeacons.intersection(scanner.transformedBeacons).count
    }
}

// MARK: - Challenge 1 Solution

func solve(scanners: [Scanner]) throws -> Int {
    scanners
        .map { $0.transformedBeacons }
        .reduce(Set<Position>()) {
            $0.union($1)
        }
        .count
}

func retrieveMatchedScanners(filename: String) throws -> [Scanner] {
    let input = try openFile(filename: filename)

    var remainingScanners = reduce(input: input)

    // scanner 0 is correct orientation + position
    // find the scanner which overlaps with it:
    var matchedScanners = [remainingScanners.remove(at: 0)]

    while !remainingScanners.isEmpty {
        for scanner in matchedScanners {
            for scannerIndex in 0..<remainingScanners.count {
                guard let scanner = scanner
                        .attemptToMatch(with: remainingScanners[scannerIndex]) else {
                    continue
                }
                matchedScanners.append(scanner)
                remainingScanners.remove(at: scannerIndex)
                break
            }
        }
    }

    return matchedScanners
}

// MARK: - Challenge 2 Solution

func solveExtension(scanners: [Scanner]) throws -> Int {
    var distances: [Int] = []
    for x in 0..<scanners.count {
        for y in 0..<scanners.count {
            distances.append(Position.manhattanDistance(scanners[x].position, b: scanners[y].position))
        }
    }

    return distances.max() ?? 0
}
