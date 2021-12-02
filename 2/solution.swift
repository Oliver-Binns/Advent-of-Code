import Foundation

try print("""
Day 2:
Sample Answer: \(solve(filename: "sample.input", using: Position.self))
Solution Answer: \(solve(filename: "solution.input", using: Position.self))

Extension Task:
Sample Answer: \(solve(filename: "sample.input", using: PositionV2.self))
Solution Answer: \(solve(filename: "solution.input", using: PositionV2.self))
""")

// MARK: - Data Source

protocol Positionable {
    var depth: Int { get }
    var horizontal: Int { get }
    
    init()
    mutating func makeMovement(by amount: (Direction, Int))
}
extension Positionable {
    var absolute: Int {
        horizontal * depth
    }
}

func solve(filename: String, using type: Positionable.Type) throws -> Int {
    try parseInput(filename: filename)
        .reduce(into: type.init()) { $0.makeMovement(by: $1) }
        .absolute
}

// MARK: - Parse input into data structure

func openFile(filename: String) throws -> String {
    let cwd = FileManager.default.currentDirectoryPath
    return try String(contentsOfFile: "\(cwd)/\(filename)", encoding: .utf8)
}

enum Direction: String {
    case forward
    case down
    case up
}

func parseInput(filename: String) throws -> [(Direction, Int)] {
     try openFile(filename: filename)
        .components(separatedBy: "\n")
        .map { $0.components(separatedBy: " " ) }
        .filter { $0.count == 2 }
        .compactMap {
            guard let direction = $0.first.map(Direction.init),
                  let amount = $0.last.map(Int.init) else { return nil }
            return (direction!, amount!)
        }
}

// MARK: - Solution 1

struct Position: Positionable {
    private(set) var depth = 0
    private(set) var horizontal = 0
    
    mutating func makeMovement(by amount: (Direction, Int)) {
        switch amount.0 {
        case .forward:
            horizontal += amount.1
        case .down:
            depth += amount.1
        case .up:
            depth -= amount.1
        }
    }
}

// MARK: - Solution 2

struct PositionV2: Positionable {
    private var aim = 0
    private(set) var depth = 0
    private(set) var horizontal = 0
    
    mutating func makeMovement(by amount: (Direction, Int)) {
        switch amount.0 {
        case .forward:
            horizontal += amount.1
            depth += amount.1 * aim
        case .down:
            aim += amount.1
        case .up:
            aim -= amount.1
        }
    }
}
