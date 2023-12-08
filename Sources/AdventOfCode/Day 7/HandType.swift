enum HandType: Int {
    case fiveOfAKind
    case fourOfAKind
    case fullHouse
    case threeOfAKind
    case twoPair
    case onePair
    case highCard
}

extension HandType: Comparable {
    static func < (lhs: HandType, rhs: HandType) -> Bool {
        lhs.rawValue > rhs.rawValue
    }
}
