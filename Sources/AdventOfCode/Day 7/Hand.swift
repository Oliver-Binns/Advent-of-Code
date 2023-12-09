struct Hand: Equatable {
    let cards: [Card]
    
    var part2: Hand {
        let cards = cards.replacing([.jack], with: [.joker])
        return Hand(cards: cards)
    }
    
    var type: HandType {
        let withoutJokers = cards.filter { $0 != .joker }
        let jokerCount = 5 - withoutJokers.count
        let countsArray = Array(
            Dictionary(withoutJokers.map { ($0, 1) },
                       uniquingKeysWith: +)
                .values
        ).incrementingMax(by: jokerCount)
        
        let counts = Dictionary(countsArray.map { ($0, 1) }, 
                                uniquingKeysWith: +)
        
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

extension Array where Element == Int {
    func incrementingMax(by count: Int) -> Self {
        guard let maxValue = self.max(),
              let index = firstIndex(of: maxValue) else {
            // all cards in the hand are Jokers!
            return [5]
        }
        var value = self
        value[index] += count
        return value
    }
}
