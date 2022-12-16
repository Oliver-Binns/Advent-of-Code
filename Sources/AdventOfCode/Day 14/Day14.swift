struct Day14: Solution {
    static let day = 14
    
    let path: [[Position]]
    
    init(input: String) {
        path = input
            .components(separatedBy: .newlines)
            .filter(!\.isEmpty)
            .map {
                $0
                    .components(separatedBy: " -> ")
                    .map { $0.components(separatedBy: ",").compactMap(Int.init) }
                    .map {
                        Position(x: $0[0], y: $0[1])
                    }
            }
    }
    
    func calculatePartOne() -> Int {
        0
    }
    
    func calculatePartTwo() -> Int {
        0
    }
}
