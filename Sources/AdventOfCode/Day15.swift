final class Day15: Solution {
    let day = 15
    let numbers: [Int]
    
    init(input: String) {
        numbers = input
            .filter { !$0.isWhitespace }
            .split(separator: ",")
            .map(String.init)
            .compactMap(Int.init)
    }
    
    func calculatePartOne() -> Int {
        0
    }
    
    func calculatePartTwo() -> Int {
        0
    }
}

struct MemoryGame {
    let currentTurn: Int
    let mentionedNumbers: [Int: Int]
    
    func nextNumber() -> Int {
        0
    }
}
