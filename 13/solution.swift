import Foundation

try print("""
Day 13:
Sample Answer: \(solve(filename: "sample.input"))
Solution Answer: \(solve(filename: "solution.input"))

Extension Task:
Sample Answer: \(solveExtension(filename: "sample.input"))
Solution Answer: \(solveExtension(filename: "solution.input"))
""")

// MARK: - Parse input into data structure

struct Dot: Hashable {
    let x, y: Int
}
enum Fold {
    case x(Int)
    case y(Int)
}

func openFile(filename: String) throws -> String {
    let cwd = FileManager.default.currentDirectoryPath
    return try String(contentsOfFile: "\(cwd)/\(filename)", encoding: .utf8)
}

func splitSections(input: String) -> (Set<Dot>, [Fold]) {
    let sections = input.components(separatedBy: "\n\n")
        .map { $0.components(separatedBy: "\n").filter { !$0.isEmpty } }
    
    let dots = sections[0]
        .compactMap { $0.components(separatedBy: ",").compactMap(Int.init) }
        .map { Dot(x: $0[0], y: $0[1]) }
        .reduce(into: Set<Dot>()) { dotSet, newValue in
            dotSet.insert(newValue)
        }
    
    let folds: [Fold] = sections[1]
        .compactMap { $0.components(separatedBy: "=") }
        .compactMap {
            guard let value = Int($0[1]) else { return nil }
            switch $0[0].last {
            case "x":
                return .x(value)
            default:
                return .y(value)
            }
        }
    
    return (dots, folds)
}

// MARK: - Folding Operations

func fold(dots: Set<Dot>, at position: Fold) -> Set<Dot> {
    dots.reduce(into: Set<Dot>()) { dotSet, dot in
        switch position {
        case .x(let value):
            let xValue = dot.x < value ? dot.x : value - (dot.x - value)
            dotSet.insert(Dot(x: xValue, y: dot.y))
        case .y(let value):
            let yValue = dot.y < value ? dot.y : value - (dot.y - value)
            dotSet.insert(Dot(x: dot.x, y: yValue))
        }
    }
}

func printGrid(dots: Set<Dot>) -> String {
    guard let maxX = dots.map({ $0.x }).max(),
          let maxY = dots.map({ $0.y }).max() else {
        return "Error: No Dots Present"
    }
    
    return (0...maxY).map { y in
        (0...maxX).map { x in
            dots.contains(Dot(x: x, y: y)) ? "#": " "
        }.joined()
    }.joined(separator: "\n")
}

// MARK: - Challenge 1 Solution
func solve(filename: String) throws -> Int {
    let input = try openFile(filename: filename)
    let (dots, folds) = splitSections(input: input)
    return fold(dots: dots, at: folds[0]).count
}

// MARK: - Challenge 2 Solution
func solveExtension(filename: String) throws -> String {
    let input = try openFile(filename: filename)
    let (dots, folds) = splitSections(input: input)
    let manual = folds.reduce(dots) { dots, nextFold in
        fold(dots: dots, at: nextFold)
    }
    return "\n\n\(printGrid(dots: manual))\n"
}
