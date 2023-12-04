struct Day4: Solution {
    static let day = 4
    
    let scratchCards: [ScratchCard]
    
    init(input: String) {
        scratchCards = input
            .components(separatedBy: .newlines)
            .filter { !$0.isEmpty }
            .map(ScratchCard.init)
    }

    func calculatePartOne() -> Int {
        scratchCards
            .map(\.value)
            .reduce(0, +)
    }
    
    func calculatePartTwo() -> Int {
        var counter: [Int: Int] = (0..<scratchCards.count)
            .reduce(into: [:]) { dictionary, index in
                dictionary[index] = 1
            }
        
        for (index, card) in scratchCards.enumerated() {
            let cardsWon = card.totalMatchingNumbers
            let lowerBound = index + 1
            let upperBound = cardsWon + index
            
            if cardsWon > 0 {
                (lowerBound...upperBound).forEach {
                    counter[$0, default: 0] += counter[index, default: 0]
                }
            }
        }
        
        return counter
            .values
            .reduce(0, +)
    }
}
