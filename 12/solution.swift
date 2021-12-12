import Foundation

try print("""
Day 12:
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
}

func parseLines(input: String) -> [[String]] {
    input
        .components(separatedBy: "\n")
        .filter { !$0.isEmpty }
        .map { $0.components(separatedBy: "-") }
        .filter { $0.count == 2 }
}

// MARK: - Data Structure

enum CaveSize {
    case big, small
}

struct Cave {
    let name: String
}


// MARK: - Challenge 1 Solution
func solve(filename: String) throws -> Int {
    let input = try openFile(filename: filename)
    let connections = parseLines(input: input)
    let reverseConnections = connections.map { $0.reversed() }
    let grid = 

    return 0
} 

// MARK: - Challenge 2 Solution
func solveExtension(filename: String) throws -> Int {
    0
} 