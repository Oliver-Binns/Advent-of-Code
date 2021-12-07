import Foundation

try print("""
Day 7:
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

func horizontalPositions(input: String) -> [Int] {
   input.filter { !$0.isWhitespace }
        .components(separatedBy: ",")
        .compactMap(Int.init)
        .sorted()
}

// MARK: - Extensions

extension ClosedRange where Bound: BinaryInteger {
    var median: Bound {
        Bound((Double(lowerBound) + Double(upperBound)) / 2)
    }
}

extension Array where Element: Hashable {
    func removingDuplicates() -> Self {
        reduce(into: []) { array, nextValue in
            if !array.contains(nextValue) {
                array.append(nextValue)
            }
        }
    }
}

func triangleNumber(_ n: Int) -> Int {
    switch n {
    case Int.min..<0:
        return (n...1).reduce(0, +)
    case 0:
        return 0
    default:
        return (1...n).reduce(0, +)
    }
}

func calculateMovement(from x: Int, to y: Int, using transform: (Int) -> Int) -> Int {
    transform(abs(y - x))
}

func fuelRequired(toAlign crabs: [Int: Int],
                  at position: Int,
                  with transform: (Int) -> Int) -> Int {
    crabs.map {
        calculateMovement(from: position, to: $0.key, using: transform)
            * $0.value
    }.reduce(0, +)
}

func binarySearch(through array: [() -> Int],
                  range: ClosedRange<Int>? = nil) -> Int? {
    let searchRange = range ?? array.startIndex...array.endIndex
    
    guard searchRange.count > 2 else {
        return [searchRange.lowerBound, searchRange.upperBound]
            .map { array[$0]() }
            .min()
    }
    
    let median = searchRange.median
    let testRange = [median-1, median, median+1].map { array[$0]() }
    
    // We are looking for a local minima
    if abs(testRange[0]) < abs(testRange[1]) {
        // must be smaller
        return binarySearch(through: array, range: searchRange.lowerBound...median)
    } else {
        // must be larger
        return binarySearch(through: array, range: median...searchRange.upperBound)
    }
}

// MARK: - Solve Challenge 1

func solve(filename: String,
           transform: @escaping (Int) -> Int = { $0 }) throws -> Int {
    let input = try openFile(filename: filename)
    let positions = horizontalPositions(input: input)
    let possiblePositions = positions.first!...positions.last!
    
    let crabs = Dictionary(positions.map { ($0, 1) }, uniquingKeysWith: +)
    
    let mapped = possiblePositions
        .reversed()
        .map { value in
            {
                fuelRequired(toAlign: crabs, at: value, with: transform)
            }
        }
    return binarySearch(through: mapped) ?? -1
}

// MARK: - Solve Challenge 2

func solveExtension(filename: String) throws -> Int {
    try solve(filename: filename, transform: triangleNumber)
}
