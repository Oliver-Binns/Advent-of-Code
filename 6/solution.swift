import Foundation

try print("""
Day 6:
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

// MARK: - Map to Next Day

func reproduceToday(dictionary: [Int: Int], range: Int) -> [Int: Int] {
    dictionary.reduce(into: [:]) { accumulating, entry in
        guard entry.key > 0 else {
            accumulating[6, default: 0] += entry.value
            accumulating[8, default: 0] += entry.value
            return
        }
        accumulating[entry.key - 1, default: 0] += entry.value
    }
}

func growthOverDays(start: [Int], numberOfDays: Int) -> Int {
    (0..<numberOfDays)
        .reduce(Dictionary(start.map { ($0, 1) }, uniquingKeysWith: +), reproduceToday)
        .values.reduce(0, +)
}

// MARK: - Solve Challenge 1

func solve(filename: String, numberOfDays: Int = 80) throws -> Int {
    let input = try openFile(filename: filename)
        .filter { !$0.isWhitespace }
        .components(separatedBy: ",")
        .compactMap(Int.init)
    return growthOverDays(start: input, numberOfDays: numberOfDays)
}

// MARK: - Solve Challenge 2

func solveExtension(filename: String) throws -> Int {
    try solve(filename: filename, numberOfDays: 256)
}
