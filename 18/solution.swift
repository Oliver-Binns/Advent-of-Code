import Foundation

try print("""
Day 18:
Sample Answer: \(solve(filename: "sample.input"))
Solution Answer: \(solve(filename: "solution.input"))

Extension Task:
Sample Answer: \(solveExtension(filename: "sample.input"))
Solution Answer: \(solveExtension(filename: "solution.input"))
""")

// MARK: - Parse input into data structure

func openFile(filename: String) throws -> String {
    let cwd = FileManager.default.currentDirectoryPath
    return try String(contentsOfFile: "\(cwd)/\(filename)", encoding: .utf8)
        .trimmingCharacters(in: .whitespacesAndNewlines)
}

func parseInput(_ input: String) throws -> [SnailfishNumber] {
    try input.components(separatedBy: "\n").map(decodeLine)
}

func decodeLine(_ line: String) throws -> SnailfishNumber {
    try JSONDecoder().decode(SnailfishNumber.self,
                             from: line.data(using: .utf8)!)
}

// MARK: - Data Structure

enum SnailfishNumber: Equatable {
    case number(Int)
    indirect case pair(SnailfishNumber, SnailfishNumber)
}

enum Direction: Equatable {
    case left
    case right
    case root(SnailfishNumber)
}
extension Direction {
    var flip: Direction {
        switch self {
        case .left: return .right
        case .right: return .left
        default: return self
        }
    }
}
extension Array where Element == Direction {
    func flippingFinalOccurence(of direction: Direction) -> Self? {
        guard let index = lastIndex(of: direction) else { return nil }
        var copy = self
        for i in index..<copy.endIndex {
            copy[i] = copy[i].flip
        }
        return copy
    }
}

extension SnailfishNumber: Decodable {
    init(from decoder: Decoder) throws {
        var container = try decoder.unkeyedContainer()
        let left: SnailfishNumber
        let right: SnailfishNumber

        do {
            left = try .number(container.decode(Int.self))
        } catch {
            left = try container.decode(SnailfishNumber.self)
        }

        do {
            right = try .number(container.decode(Int.self))
        } catch {
            right = try container.decode(SnailfishNumber.self)
        }

        self = .pair(left, right)
    }
}

// MARK: - Operators

extension SnailfishNumber: CustomStringConvertible {
    var description: String {
        switch self {
        case .number(let number):
            return String(number)
        case .pair(let left, let right):
            return "[\(left), \(right)]"
        }
    }
}

extension SnailfishNumber {
    var nestedPairs: Int {
        switch self {
        case .number:
            return 0
        case .pair(let left, let right):
            return max(1 + left.nestedPairs, 1 + right.nestedPairs)
        }
    }

    var containsLargeNumber: Bool {
        switch self {
        case .number(let value):
            return value >= 10
        case .pair(let left, let right):
            return left.containsLargeNumber || right.containsLargeNumber
        }
    }

    func explode() -> SnailfishNumber {
        switch self {
        case .number:
            return self
        default:
            let position = findPair(atDepth: 4)
            return explode(at: position)
        }
    }

    private func findPair(atDepth depth: Int) -> [Direction] {
        switch self {
        case .pair(.number, .number):
            return [.root(self)]
        case .pair(.number, let right):
            return [.right] + right.findPair(atDepth: depth - 1)
        case .pair(let left, .number):
            return [.left] + left.findPair(atDepth: depth - 1)
        case .pair(let left, let right):
            let leftPair = left.findPair(atDepth: depth - 1)
            if leftPair.count >= depth {
                return [.left] + leftPair
            } else {
                return [.right] + right.findPair(atDepth: depth - 1)
            }
        default: preconditionFailure("number is not a pair")
        }
    }

    private func explode(at position: [Direction]) -> SnailfishNumber {
        guard case .root(.pair(.number(let rootLeft), .number(let rootRight))) = position.last
            else { return self }
        var exploded = replaceItem(at: position, with: .number(0))

        if let flipFinalRight = position.flippingFinalOccurence(of: .right) {
            exploded = exploded.addValue(rootLeft, atPosition: flipFinalRight, from: .left)
        }
        if let flipFinalLeft = position.flippingFinalOccurence(of: .left) {
            exploded = exploded.addValue(rootRight, atPosition: flipFinalLeft, from: .right)
        }

        return exploded
    }

    private func replaceItem(at position: [Direction],
                             with value: SnailfishNumber) -> SnailfishNumber {
        if position.count == 1 {
            return value
        }
        guard case .pair(let left, let right) = self else { return self }

        let indexOne = position.index(position.startIndex, offsetBy: 1)
        let nextPosition = Array(position.suffix(from: indexOne))

        switch position.first {
        case .left:
            return .pair(left.replaceItem(at: nextPosition, with: value), right)
        case .right:
            return .pair(left, right.replaceItem(at: nextPosition, with: value))
        default: return self
        }
    }

    private func addValue(_ value: Int, atPosition position: [Direction], from direction: Direction) -> SnailfishNumber {
        if case .number(let originalValue) = self {
            return .number(originalValue + value)
        }

        guard case .pair(let left, let right) = self else { return self }

        let indexOne = position.index(position.startIndex, offsetBy: 1)
        let nextPosition = Array(position.suffix(from: indexOne))

        switch position.first {
        case .left:
            return .pair(left.addValue(value, atPosition: nextPosition, from: direction), right)
        case .right:
            return .pair(left, right.addValue(value, atPosition: nextPosition, from: direction))
        default:
            switch direction {
            case .left:
                return .pair(left, right.addValue(value, atPosition: [direction], from: direction))
            case .right:
                return .pair(left.addValue(value, atPosition: [direction], from: direction), right)
            default: return self
            }
        }
    }

    var canSplit: Bool {
        switch self {
        case .number(let value):
            return value >= 10
        case .pair(let left, let right):
            return left.canSplit || right.canSplit
        }
    }

    func split() -> SnailfishNumber {
        switch self {
        case .number(let value):
            guard value >= 10 else { return self }
            let floor = value / 2
            let ceiling = Int(ceil(Double(value) / 2))
            return .pair(.number(floor), .number(ceiling))
        case .pair(let left, let right):
            if left.canSplit {
                return .pair(left.split(), right)
            }
            return .pair(left, right.split())
        }
    }

    func reduce() -> SnailfishNumber {
        var mutableSelf = self

        while mutableSelf.nestedPairs > 4 || mutableSelf.containsLargeNumber {
            if mutableSelf.nestedPairs > 4 {
                mutableSelf = mutableSelf.explode()
            } else if mutableSelf.containsLargeNumber {
                mutableSelf = mutableSelf.split()
            }
        }

        return mutableSelf
    }

    func magnitude() -> Int {
        switch self {
        case .pair(let left, let right):
            return 3 * left.magnitude() + 2 * right.magnitude()
        case .number(let value):
            return value
        }
    }
}

// MARK: - Challenge 1 Solution

func solve(filename: String) throws -> Int {
    let input = try openFile(filename: filename)
    let snailfish = try parseInput(input)

    var addition = snailfish[0]
    for i in 1..<snailfish.count {
        addition = .pair(addition, snailfish[i]).reduce()
    }

    return addition.magnitude()
}

// MARK: - Challenge 2 Solution

func solveExtension(filename: String) throws -> Int {
    let input = try openFile(filename: filename)
    let snailfish = try parseInput(input)

    var magnitudes: [Int] = []
    for i in 0..<snailfish.count {
        for j in 0..<snailfish.count {
            magnitudes.append(
                SnailfishNumber.pair(snailfish[i], snailfish[j]).reduce().magnitude()
            )
        }
    }

    return magnitudes.max() ?? 0
}
