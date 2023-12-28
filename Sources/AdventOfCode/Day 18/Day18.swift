struct Day18: Solution {
    static let day = 18
    
    let digPlan: [DigInstruction]
    
    init(input: String) {
        digPlan = input
            .components(separatedBy: .newlines)
            .filter(\.isNotEmpty)
            .compactMap(DigInstruction.init)
    }
    
    
    
    func calculatePartOne() -> Int {
        digPlan
            .reduce(Terrain()) {
                $0.dig(instruction: $1)
            }
            .cubicMeters
    }
    
    func calculatePartTwo() -> Int {
        0
    }
}
