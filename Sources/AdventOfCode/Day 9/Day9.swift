import Algorithms

struct Day9: Solution {
    static let day = 9
    
    let report: [[Int]]
    
    init(input: String) {
        report = input
            .components(separatedBy: .newlines)
            .map {
                $0
                    .components(separatedBy: .whitespaces)
                    .compactMap(Int.init)
            }
            .filter { !$0.isEmpty }
    }
    
    enum Direction {
        case up
        case down
        
        var keyPath: KeyPath<[Int], Int?> {
            self == .up ? \.last : \.first
        }
        
        func compose(for row: Int) -> ((Int, Int) -> Int) {
            switch self {
            case .up: return (+)
            case .down where row.isMultiple(of: 2):
                return (+)
            default:
                return (-)
            }
        }
    }
    
    func findNextValue(row: [Int],
                       direction: Direction = .up) -> Int {
        var differences = [row]
        while let last = differences.last,
              last.contains(where: { $0 != 0 }) {
            differences.append(getNextSequence(row: last))
        }
        
        return differences
            .compactMap { $0[keyPath: direction.keyPath] }
            .enumerated()
            .reduce(0) { currentTotal, nextValue in
                let composeMethod = direction.compose(for: nextValue.offset)
                return composeMethod(currentTotal, nextValue.element)
            }
    }
    
    func getNextSequence(row: [Int]) -> [Int] {
        row.windows(ofCount: 2)
            .compactMap {
                guard let first = $0.first,
                      let last = $0.last else {
                    return nil
                }
                return last - first
            }
    }
    
    func calculatePartOne() -> Int {
        report
            .map { findNextValue(row: $0) }
            .reduce(0, +)
    }
    
    func calculatePartTwo() -> Int {
        report
            .map { findNextValue(row: $0, direction: .down) }
            .reduce(0, +)
    }
}
