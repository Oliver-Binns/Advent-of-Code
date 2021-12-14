import Foundation

try print("""
Day 14:
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

func splitSections(input: String) -> (String, [String: String]) {
    let sections = input.components(separatedBy: "\n\n")
    return (sections[0], sections[1]
        .components(separatedBy: "\n")
        .map { $0.components(separatedBy: " -> ") }
        .reduce(into: [:]) { dictionary, newValue in
            dictionary[newValue[0]] = newValue[1]
        })
}

extension String {
    func chunked(into size: Int) -> [String] {
        (0..<count-1).map {
            let startIndex = index(self.startIndex, offsetBy: $0)
            let endIndex = index(self.startIndex, offsetBy: Swift.min($0 + size, count))
            return String(self[startIndex..<endIndex])
        }
    }
}

// MARK: - Solve Challenge 1

func solve(filename: String, stepCount: Int = 10) throws -> Int {
    let input = try openFile(filename: filename)
    let (polymerTemplate, insertionRules) = splitSections(input: input)
    let chunks = polymerTemplate.chunked(into: 2).map { ($0, 1) }
    let counts = (0..<stepCount)
        .reduce(Dictionary(chunks, uniquingKeysWith: +)) { counts, _ in
        counts.reduce(into: [:]) { dictionary, newValue in
            guard let first = newValue.key.first,
                  let middle = insertionRules[newValue.key],
                  let last = newValue.key.last else {
                      return
                  }
            dictionary["\(first)\(middle)", default: 0] += newValue.value
            dictionary["\(middle)\(last)", default: 0] += newValue.value
        }
    }
    
    let lastCharacter = polymerTemplate.last!
    let values: [Character: Int] = counts.reduce(into: [lastCharacter: 1]) { dictionary, newValue in
        guard let first = newValue.key.first else { return }
        dictionary[first, default: 0] += newValue.value
    }
    
    return values.values.max()! - values.values.min()!
}

// MARK: - Solve Challenge 2

func solveExtension(filename: String) throws -> Int {
   try solve(filename: filename, stepCount: 40)
}
