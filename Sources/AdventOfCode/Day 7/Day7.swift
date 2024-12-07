struct Day7: Solution {
    static let day = 7

    let equations: [Equation]

    init(input: String) {
        equations = input
            .components(separatedBy: .newlines)
            .compactMap(Equation.init)
    }
    
    func calculatePartOne() -> Int {
        calculateAnswer(supportedOperators: [(*), (+)])
    }
    
    func calculatePartTwo() -> Int {
        calculateAnswer(supportedOperators: [(*), (+), (||)])
    }

    func calculateAnswer(
        supportedOperators: [(Int, Int) -> Int]
    ) -> Int {
        equations
            .filter { $0.canBeMet(supportedOperators: supportedOperators) }
            .map(\.total)
            .reduce(0, +)
    }
}

extension Day7 {
    struct Equation: Equatable {
        let total: Int
        let components: [Int]
    }
}

extension Day7.Equation {
    init?(_ input: String) {
        let properties = input.split(separator: ":")
        guard properties.count == 2,
            let total = Int(properties[0]) else {
            return nil
        }
        self.total = total
        self.components = properties[1]
            .components(separatedBy: .whitespaces)
            .compactMap(Int.init)
    }

    func canBeMet(
        supportedOperators: [(Int, Int) -> Int] = [(*), (+)]
    ) -> Bool {
        components.suffix(from: 1)
            .reduce([components[0]]) { partialResult, nextValue in
                partialResult.flatMap { value in
                    supportedOperators.map { op in
                        op(value, nextValue)
                    }
                }
            }
            .contains(total)
    }
}

func || (lhs: Int, rhs: Int) -> Int {
    guard let value = Int(String(lhs) + String(rhs)) else {
        fatalError("Cannot join \(lhs) and \(rhs)")
    }
    return value
}
