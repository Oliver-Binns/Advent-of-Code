import Foundation

try print("""
Day 23:
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

func parseInput(_ input: String) -> [Line] {
    input
        .components(separatedBy: "\n")
        .compactMap(parseLine)
}

func parseLine(_ line: String) -> Line? {
    let components = line.components(separatedBy: " ")
    guard let operation = Operation(rawValue: components[0]),
          let store = components[1].first else {
        return nil
    }
    if operation == .input {
        return (operation, store, .none)
    } else if let integerValue = Int(components[2]) {
        return (operation, store, .value(integerValue))
    } else if let calculate = components[2].first {
        return (operation, store, .variable(calculate))
    }
    return nil
}

// MARK: - Data Structure

enum Operation: String, Equatable {
    case input = "inp"
    case add = "add"
    case multiply = "mul"
    case divide = "div"
    case modulo = "mod"
    case equals = "eql"
}

enum InputValue {
    case variable(Character)
    case value(Int)
    case none
}

typealias Line = (Operation, Character, InputValue)

func runProgramme(_ lines: [Line], initialState: [Character: Int]) -> [Character: Int] {
    lines.reduce(into: initialState) { variables, nextLine in
        switch nextLine.0 {
        case .input: break
        case .add:
            if case .value(let value) = nextLine.2 {
                variables[nextLine.1, default: 0] += value
            } else if case .variable(let variable) = nextLine.2 {
                variables[nextLine.1, default: 0] += variables[variable, default: 0]
            }
        case .multiply:
            if case .value(let value) = nextLine.2 {
                variables[nextLine.1, default: 0] *= value
            } else if case .variable(let variable) = nextLine.2 {
                variables[nextLine.1, default: 0] *= variables[variable, default: 0]
            }
        case .divide:
            if case .value(let value) = nextLine.2 {
                variables[nextLine.1, default: 0] /= value
            } else if case .variable(let variable) = nextLine.2 {
                variables[nextLine.1, default: 0] /= variables[variable, default: 0]
            }
        case .modulo:
            if case .value(let value) = nextLine.2 {
                variables[nextLine.1, default: 0] %= value
            } else if case .variable(let variable) = nextLine.2 {
                variables[nextLine.1, default: 0] %= variables[variable, default: 0]
            }
        case .equals:
            if case .value(let value) = nextLine.2 {
                let areEqual = variables[nextLine.1, default: 0] == value
                variables[nextLine.1, default: 0] = areEqual ? 1 : 0
            } else if case .variable(let variable) = nextLine.2 {
                let areEqual = variables[nextLine.1, default: 0] == variables[variable, default: 0]
                variables[nextLine.1, default: 0] = areEqual ? 1 : 0
            }
        }
    }
}

// MARK: - Challenge 1 Solution
func solve(filename: String) throws -> String {
    try solve(filename: filename, using: >)
}

func solve(filename: String, using comparison: (Int, Int) -> Bool) throws -> String {
    let input = try openFile(filename: filename)
    let lines = parseInput(input)
    let sections = lines
        .split(whereSeparator: { $0.0 == .input })
        .filter { !$0.isEmpty }
        .map(Array.init)

    let value: [Int: String] = sections.reduce([0: ""]) { inputStates, nextSection in
        var newDictionary: [Int: String] = [:]

        inputStates.forEach { (z, string) in
            (1..<10).forEach { w in
                let state = runProgramme(nextSection, initialState: ["w": w, "z": z])
                let newZ = state["z", default: 0]
                let newString = string + "\(w)"

                if let string = newDictionary[newZ],
                    let overwriting = Int(string),
                    let overwriteWith = Int(newString),
                    comparison(overwriteWith, overwriting) {
                    newDictionary[newZ] = newString
                } else if newDictionary[newZ] == nil {
                    newDictionary[newZ] = newString
                }
            }
        }

        return newDictionary
    }
    return value[0] ?? "Fail"
}

// MARK: - Challenge 2 Solution

func solveExtension(filename: String) throws -> String {
    try solve(filename: filename, using: <)
}
