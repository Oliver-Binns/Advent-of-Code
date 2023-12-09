struct Day7: Solution {
    static let day = 7
    
    let players: [(Hand, Int)]
    var playersPart2: [(Hand, Int)] {
        players
            .map {
                ($0.0.part2, $0.1)
            }
    }
    
    init(input: String) {
        players = input
            .components(separatedBy: .newlines)
            .filter { !$0.isEmpty }
            .map {
                let parts = $0.components(separatedBy: .whitespaces)
                let cards = parts[0]
                    .map(String.init)
                    .compactMap(Card.init)
                guard let bid = Int(parts[1]) else {
                    preconditionFailure("Invalid input format")
                }
                return (Hand(cards: cards), bid)
            }
    }
    
    private func calculate(for keyPath: KeyPath<Self, [(Hand, Int)]>) -> Int {
        self[keyPath: keyPath]
            .sorted(by:  { $0.0 < $1.0 })
            .map(\.1)
            .enumerated()
            .map { ($0 + 1) * $1 }
            .reduce(0, +)
    }
    
    func calculatePartOne() -> Int {
        calculate(for: \.players)
    }
    
    func calculatePartTwo() -> Int {
        calculate(for: \.playersPart2)
    }
}
