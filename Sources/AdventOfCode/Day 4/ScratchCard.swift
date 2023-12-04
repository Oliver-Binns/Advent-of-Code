struct ScratchCard: Equatable {
    let winningNumbers: Set<Int>
    let chosenNumbers: [Int]
    
    init(winningNumbers: Set<Int>, chosenNumbers: [Int]) {
        self.winningNumbers = winningNumbers
        self.chosenNumbers = chosenNumbers
    }
    
    init(rawString: String) {
        let trimmedPrefix = rawString
            .split(separator: ":")[1]
            .split(separator: "|")
            .map { $0.split(separator: " ") }
        
        
        
        self.winningNumbers = Set(
            trimmedPrefix[0]
                .compactMap { Int($0) }
        )
            
        self.chosenNumbers = trimmedPrefix[1]
            .compactMap { Int($0) }
    }
    
    var value: Int {
        chosenNumbers
            .filter { winningNumbers.contains($0) }
            .reduce(0) { value, _ in
                if value == 0 {
                    return 1
                } else {
                    return value * 2
                }
            }
    }
    
    var totalMatchingNumbers: Int {
        chosenNumbers
            .filter { winningNumbers.contains($0) }
            .count
    }
}
