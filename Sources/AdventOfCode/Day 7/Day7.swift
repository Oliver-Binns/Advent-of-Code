struct Day7: Solution {
    static let day = 7
    
    let players: [(Hand, Int)]
    
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
    
    func calculatePartOne() -> Int {
        players
            .sorted(by:  { $0.0 < $1.0 })
            .map(\.1)
            .enumerated()
            .map { ($0 + 1) * $1 }
            .reduce(0, +)
    }
    
    func calculatePartTwo() -> Int {
        0
    }
}
