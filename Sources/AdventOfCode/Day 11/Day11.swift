import Algorithms

struct Day11: Solution {
    static let day = 11
    
    let universe: Universe
    
    init(input: String) {
        universe = Universe(rawValue: input)
    }
    
    
    func calculatePairLengths(age: Int) -> Int {
        universe
            .expanded(age: age)
            .galaxyLocations
            .combinations(ofCount: 2)
            .map {
                abs($0[1].y - $0[0].y) +
                abs($0[1].x - $0[0].x)
            }
            .reduce(0, +)
    }
    
    func calculatePartOne() -> Int {
        calculatePairLengths(age: 1)
    }
    
    func calculatePartTwo() -> Int {
        calculatePairLengths(age: 999_999)
    }
}
