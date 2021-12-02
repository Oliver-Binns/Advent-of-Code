import Foundation

extension Array {
    func removingFirst() -> Self {
        var copy = self
        copy.removeFirst()
        return copy
    }
}

func zip3<T>(_ first: [T], _ second: [T], _ third: [T]) -> [(T, T, T)] {
    zip(zip(first, second), third).map {
        ($0.0, $0.1, $1)
    }
}

func openFile(filename: String) throws -> String {
    let cwd = FileManager.default.currentDirectoryPath
    return try String(contentsOfFile: "\(cwd)/\(filename)", encoding: .utf8)
}

func parseInput(filename: String) throws -> [Int] {
     try openFile(filename: filename)
        .components(separatedBy: "\n")
        .compactMap(Int.init)
}

func solve(input: [Int]) -> Int {
    zip(input, input.removingFirst())
        .filter { $0.0 < $0.1 }
        .count
}

func solve(filename: String) throws -> Int {
    let input = try parseInput(filename: filename)
    return solve(input: input)
}

func solveExtension(filename: String) throws -> Int {
    let input = try parseInput(filename: filename)
    return solve(input:
        zip3(input, input.removingFirst(), input.removingFirst().removingFirst())
            .map { $0.0 + $0.1 + $0.2 }
    )
}

try print("""
Day 1:
Sample Answer: \(solve(filename: "sample.input"))
Solution Answer: \(solve(filename: "solution.input"))

Extension Task:
Sample Answer: \(solveExtension(filename: "sample.input"))
Solution Answer: \(solveExtension(filename: "solution.input"))
""")
