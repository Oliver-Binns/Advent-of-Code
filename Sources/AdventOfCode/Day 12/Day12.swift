struct Day12: Solution {
    static let day = 12
    
    let rows: [Row]
    
    init(input: String) {
        rows = input
            .components(separatedBy: .newlines)
            .filter(\.isNotEmpty)
            .compactMap(Row.init)
    }
    
    func calculatePartOne() -> Int {
        rows.map(\.possibleArrangements)
            .reduce(0, +)
    }
    
    func calculatePartTwo() -> Int {
        rows.map(\.part2)
            .map(\.possibleArrangements)
            .reduce(0, +)
    }
}
