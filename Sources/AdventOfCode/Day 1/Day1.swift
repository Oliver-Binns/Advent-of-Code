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
            Int(SearchDirection.allCases.map {
                searchString(line, direction: $0, isPartTwo: isPartTwo)
            }.joined())
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
    func checkEndOfString(_ string: String,
                          indexPath: KeyPath<String, String.Index>,
                          find: (String, String) -> Bool,
                          isPartTwo: Bool = false) -> String? {
        let index = string[keyPath: indexPath]
        if string[index].isNumber {
            return String(string[index])
        } else if isPartTwo {
            for (index, number) in numbersToFind.enumerated()
            where find(string, number) {
                return index.description
            }
        }
        
        return nil
    }
    
    func searchString(_ string: String, 
                      direction: SearchDirection,
                      isPartTwo: Bool = false) -> String {
        for i in direction.iteration(over: string) {
            let index = string.index(string.startIndex, offsetBy: i)
            let substring = direction.substring(of: string, around: index)
            if let number = checkEndOfString(String(substring),
                                             indexPath: direction.indexPath,
                                             find: direction.checkEnd,
                                             isPartTwo: isPartTwo) {
                return number
            }
        }
        preconditionFailure("Expected to find at least one number in string")
    }
    
    enum SearchDirection: CaseIterable {
        case forward
        case backward
        
        var indexPath: KeyPath<String, String.Index> {
            self == .forward ? \.startIndex : \.lastIndex
        }
        
        func iteration(over string: String) -> any Sequence<Int> {
            self == .forward ?
                0..<string.count :
                (0..<string.count).reversed()
        }
        
        func checkEnd(of string: String, for value: String) -> Bool {
            self == .forward ?
                string.hasPrefix(value) :
                string.hasSuffix(value)
        }
        
        func substring(of string: String, around index: String.Index) -> Substring {
            self == .forward ?
                string[index...] :
                string[...index]
        }
    }
}
