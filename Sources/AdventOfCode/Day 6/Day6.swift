import Algorithms

struct Day6: Solution {
    static let day = 6
    
    let input: String
    
    init(input: String) {
        self.input = input
    }

    func calculatePartOne() -> Int {
       findMarker(ofLength: 4)
    }
    
    func calculatePartTwo() -> Int {
        findMarker(ofLength: 14)
    }
    
    func findMarker(ofLength length: Int) -> Int {
        guard let index = input
            .windows(ofCount: length)
            .enumerated()
            .first(where: { (index, value) in
                Set(Array(value)).count == length
            }) else {
            preconditionFailure("No marker found")
        }
        return index.offset + length
    }
}
