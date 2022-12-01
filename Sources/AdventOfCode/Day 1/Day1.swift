struct Day1: Solution {
    static let day = 1
    
    let caloriesCarried: [Int]
    
    init(input: String) {
        caloriesCarried = input
            .components(separatedBy: "\n\n")
            .map {
                $0
                    .components(separatedBy: .newlines)
                    .compactMap(Int.init)
                    .reduce(0, +)
            }
            .sorted(by: >)
    }

    func calculatePartOne() -> Int {
        caloriesCarried[0]
    }
}

extension Day1 {
    func calculatePartTwo() -> Int {
        caloriesCarried[0...2].reduce(0, +)
    }
}
