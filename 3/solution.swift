import Foundation

try print("""
Day 3:
Sample Answer: \(solve(filename: "sample.input"))
Solution Answer: \(solve(filename: "solution.input"))

Extension Task:
Sample Answer: \(solveExtension(filename: "sample.input"))
Solution Answer: \(solveExtension(filename: "solution.input"))
""")

// MARK: - Parse input into data structure

enum InputError: Error {
    case empty
    case invalidBinaryValue
}

func openFile(filename: String) throws -> String {
    let cwd = FileManager.default.currentDirectoryPath
    return try String(contentsOfFile: "\(cwd)/\(filename)", encoding: .utf8)
}

func parseInput(filename: String) throws -> [String] {
    try openFile(filename: filename)
        .components(separatedBy: "\n")
        .filter { !$0.isEmpty }
}

// MARK: Data Types & Transformation

typealias Counter = (zeros: Int, ones: Int)

func convertInput(_ input: [String]) throws -> [Counter] {
    guard let lineLength = input.first?.count else {
        throw InputError.empty
    }
    return input
        .reduce((0..<lineLength)
        .map { _ in (zeros: 0, ones: 0) }) { counters, nextValue in
        zip(counters, nextValue).map(updateCounter)
    }
}

func updateCounter(_ counter: Counter, forCharacter character: Character) -> Counter {
    character == "0" ?
        (zeros: counter.zeros + 1, ones: counter.ones) :
        (zeros: counter.zeros, ones: counter.ones + 1)
    }
}

func binaryToDecimal(value: String?) throws -> Int {
    guard let binaryValue = value,
          let decimalValue = Int(binaryValue, radix: 2) else {
        throw InputError.invalidBinaryValue
    }
    return decimalValue
}

func binaryToDecimal(values: [String]) throws -> Int {
    try binaryToDecimal(values.joined())
}

// MARK: - Solve Challenge 1

func calculateEpsilonRate(counters: [Counter]) throws -> Int {
    try binaryToDecimal(values: counters.map { $0.zeros > $0.ones ? "1": "0" })
}

func calculateGammaRate(counters: [Counter]) throws -> Int {
    try binaryToDecimal(values: counters.map { $0.zeros > $0.ones ? "0": "1" })
}

func solve(filename: String) throws -> Int {
    let linesOfData = try parseInput(filename: filename)
    let counters = try convertInput(linesOfData)
    let gammaRate = try calculateGammaRate(counters: counters)
    let epsilonRate = try calculateEpsilonRate(counters: counters)
    return gammaRate * epsilonRate
}

// MARK: - Solve Challenge 2

func performBitFilter(data: [String], bit: Int,
                      using comparison: (Int, Int) -> Bool) throws -> [String] {
    let counters = try convertInput(data)
    let filterValue: Character = comparison(counters[bit].zeros, counters[bit].ones) ? "0" : "1"
    return data.filter { [Character]($0)[bit] == filterValue }
}

func filterBits(data: [String], using comparison: (Int, Int) -> Bool) throws -> String? {
    guard let lineLength = data.first?.count else { throw InputError.empty }
    return try (0..<lineLength).reduce(data) { remainingData, nextIndex in
        guard remainingData.count > 1 else { return remainingData }
        return try performBitFilter(data: remainingData,
                                    bit: nextIndex, using: comparison)
        
    }.first
}

func calculateOxygenGenerationRating(data: [String]) throws -> Int {
    try binaryToDecimal(value: filterBits(data: data, using: >))
}

func calculateCO2ScrubberRating(data: [String]) throws -> Int {
    try binaryToDecimal(value: filterBits(data: data, using: <=))
}

func solveExtension(filename: String) throws -> Int {
    let linesOfData = try parseInput(filename: filename)
    return try calculateOxygenGenerationRating(data: linesOfData) *
        calculateCO2ScrubberRating(data: linesOfData)
}
