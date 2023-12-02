struct Day1: Solution {
    static let day = 1
    
    let lines: [String]
    private let numbersToFind = [
        "zero",
        "one",
        "two",
        "three",
        "four",
        "five",
        "six",
        "seven",
        "eight",
        "nine"
    ]
    
    /// Initialise your solution
    ///
    /// - parameters:
    ///   - input: Contents of the `Day1.input` file within the same folder as this source file
    init(input: String) {
        lines = input
            .components(separatedBy: .newlines)
            .filter { !$0.isEmpty }
    }
    
    func runCalculation(isPartTwo: Bool = false) -> Int {
        lines.compactMap { line in
            Int(
                firstNumber(in: line, isPartTwo: isPartTwo) +
                lastNumber(in: line, isPartTwo: isPartTwo)
            )
        }.reduce(0, +)
    }

    /// Return your answer to the main activity of the advent calendar
    ///
    /// If you need to, you can change the return type of this method to any type that conforms to `CustomStringConvertible`, i.e. `String`, `Float`, etc.
    func calculatePartOne() -> Int {
        runCalculation()
    }

    /// Return your solution to the extension activity
    /// _ N.B. This is only unlocked when you have completed part one! _
    func calculatePartTwo() -> Int {
        runCalculation(isPartTwo: true)
    }
}

extension Day1 {
    func startsWith(string: String, isPartTwo: Bool = false) -> String? {
        if string[string.startIndex].isNumber {
            return String(string[string.startIndex])
        } else if isPartTwo {
            for (index, number) in numbersToFind.enumerated()
            where string.starts(with: number) {
                return index.description
            }
        }
        
        return nil
    }
    
    func endsWith(string: String, isPartTwo: Bool = false) -> String? {
        if string[string.lastIndex].isNumber {
            return String(string[string.lastIndex])
        } else if isPartTwo {
            for (index, number) in numbersToFind.enumerated()
            where string.hasSuffix(number) {
                return index.description
            }
        }
        
        return nil
    }
    
    func firstNumber(in string: String, isPartTwo: Bool = false) -> String {
        for i in 0..<string.count {
            let index = string.index(string.startIndex, offsetBy: i)
            let substring = String(string[index...])
            if let number = startsWith(string: substring, isPartTwo: isPartTwo) {
                return number
            }
        }
        preconditionFailure("Expected to find at least one number in string")
    }
    
    func lastNumber(in string: String, isPartTwo: Bool = false) -> String {
        for i in (0..<string.count).reversed() {
            let index = string.index(string.startIndex, offsetBy: i)
            let substring = String(string[...index])
            if let number = endsWith(string: substring, isPartTwo: isPartTwo) {
                return number
            }
        }
        preconditionFailure("Expected to find at least one number in string")
    }
}
