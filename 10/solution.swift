import Foundation

try print("""
Day 10:
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

func parseLines(input: String) -> [String] {
    input
        .components(separatedBy: "\n")
        .filter { !$0.isEmpty }
}

extension Character {
    var isOpening: Bool {
        "[{(<".contains(self)
    }
    
    var isClosing: Bool {
        ">)}]".contains(self)
    }
    
    var opposite: Character {
        switch self {
        case "[" : return "]"
        case "]": return "["
        case "{": return "}"
        case "}": return "{"
        case "(": return ")"
        case ")": return "("
        case "<": return ">"
        default: return "<"
        }
    }
    
    var corruptionValue: Int {
        switch self {
        case ")": return 3
        case "]": return 57
        case "}": return 1197
        default: return 25137
        }
    }
    
    var completionValue: Int {
        switch self {
        case ")": return 1
        case "]": return 2
        case "}": return 3
        default: return 4
        }
    }
}

enum InputError: Error {
    case corrupted(Character)
}

enum LineType {
    case corrupted(Character)
    case incomplete([Character])
    case valid
    case unknown
}

func typeOfLine(_ line: String) throws -> LineType {
    do {
        let remainingCharacters = try line.reduce(into: Array<Character>()) { array, nextValue in
            if nextValue.isOpening {
                array.append(nextValue)
            } else if nextValue.isClosing && array.last == nextValue.opposite {
                array.removeLast()
            } else {
                throw InputError.corrupted(nextValue)
            }
        }
        return remainingCharacters.isEmpty ?
            .valid :
            .incomplete(remainingCharacters.map { $0.opposite }.reversed())
    } catch InputError.corrupted(let character) {
        return .corrupted(character)
    }
}

// MARK: - Solve Challenge 1

func solve(filename: String) throws -> Int {
    let input = try openFile(filename: filename)
    return try parseLines(input: input)
        .map(typeOfLine)
        .compactMap { lineType -> Character? in
            if case .corrupted(let character) = lineType {
                return character
            }
            return nil
        }
        .map { $0.corruptionValue }
        .reduce(0, +)
}

// MARK - Solve Challenge 2

func solveExtension(filename: String) throws -> Int {
    let input = try openFile(filename: filename)
    let incompletionScores = try parseLines(input: input)
        .map(typeOfLine)
        .compactMap { lineType -> [Character]? in
            if case .incomplete(let remainingCharacters) = lineType {
                return remainingCharacters
            }
            return nil
        }
        .map { $0.map { $0.completionValue } }
        .map { $0.reduce(0) { totalScore, nextValue in
            totalScore * 5 + nextValue
        }}
        .sorted()
    
    let medianIndex = incompletionScores.count / 2
    
    return incompletionScores[medianIndex]
}
