struct Hand: Equatable {
    let cards: [Card]
    let type: HandType
    
    init(cards: [Card]) {
        self.cards = cards
        self.type = Self.calculateType(from: cards)
    }
    
    static func calculateType(from cards: [Card]) -> HandType {
        let countsArray = Dictionary(cards.map { ($0, 1) }, uniquingKeysWith: +)
            .values
        let counts = Dictionary(countsArray.map { ($0, 1) }, uniquingKeysWith: +)
        
        if counts[5] == 1 {
            return .fiveOfAKind
        } else if counts[4] == 1 {
            return .fourOfAKind
        } else if counts[3] == 1 {
            if counts[2] == 1 {
                return .fullHouse
            } else {
                return .threeOfAKind
            }
        } else if counts[2] == 2 {
            return .twoPair
        } else if counts[2] == 1 {
            return .onePair
        }
        return .highCard
    }
}

extension Hand: Comparable {
    static func < (lhs: Hand, rhs: Hand) -> Bool {
        guard lhs.type == rhs.type else {
            return lhs.type < rhs.type
        }
        guard let firstDifference = zip(lhs.cards, rhs.cards)
            .first(where: { $0.0 != $0.1 }) else {
            preconditionFailure("Hands are identical")
        }
        return firstDifference.0 < firstDifference.1
    }
}

extension Hand: CustomStringConvertible {
    var description: String {
        cards
            .map(\.rawValue)
            .joined()
    }
}
