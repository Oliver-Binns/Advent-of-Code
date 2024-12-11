struct Day11: Solution {
    static let day = 11
    
    let stones: [Int: Int]
    
    init(input: String) {
        stones = input
            .components(separatedBy: .whitespacesAndNewlines)
            .compactMap(Int.init)
            .reduce(into: [Int: Int]()) {
                $0[$1] = 1
            }
    }
    
    func blink(stones: [Int: Int]) -> [Int: Int] {
        stones.reduce(into: [:]) { (dictionary, element) in
            let stone = element.key
            let count = element.value
            
            switch stone {
            case 0:
                dictionary[1, default: 0] += count
            case _ where stone.description.count.isEven:
                let string = stone.description
                let halfway = string.count / 2
                guard let firstHalf = Int(string.prefix(halfway)),
                      let secondHalf = Int(string.suffix(halfway))
                else {
                    break
                }
                dictionary[firstHalf, default: 0] += count
                dictionary[secondHalf, default: 0] += count
            default:
                dictionary[stone * 2024, default: 0] += count
            }
            
        }
    }
    
    func blink(
        times: Int,
        stones: [Int: Int]
    ) -> [Int: Int] {
        (0..<times)
            .reduce(stones) { stones, _ in
                blink(stones: stones)
            }
    }
    
    func calculatePartOne() -> Int {
        blink(times: 25, stones: stones)
            .values.reduce(0, +)
        
    }
    
    func calculatePartTwo() -> Int {
        blink(times: 75, stones: stones)
            .values.reduce(0, +)
    }
}
