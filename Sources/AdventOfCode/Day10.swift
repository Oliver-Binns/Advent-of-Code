import Foundation

final class Day10: Solution {
    let day = 10
    let adapters: [Int]
    lazy var allAdapters: [Int] = {
        [0] + adapters + [adapters[adapters.count - 1] + 3]
    }()
    
    lazy var differences: [Int] = calculateDifferences()
    
    init(input: String) {
        adapters = input
            .split(whereSeparator: { $0.isWhitespace })
            .map(String.init).compactMap(Int.init)
            .sorted()
    }
    
    func calculatePartOne() -> Int {
        let summedDifferences = Dictionary(differences.map { ($0, 1) },
                                           uniquingKeysWith: +)
        
        guard let oneJolt = summedDifferences[1],
              let threeJolt = summedDifferences[3] else {
            return 0
        }
        return oneJolt * threeJolt
    }
    
    func calculatePartTwo() -> Int {
        /*var count = 1
        
        for (index, value) in differences
            .suffix(from: 1)
            .prefix(differences.count - 1)
            .enumerated() {
            switch value {
            case 1 where index > 0 && differences[index - 1] == 1:
                if index > 1 && differences[index - 2] == 1 {
                    count += 2
                } else {
                    count += 1
                }
            default:
                // cannot skip adapters when there is a difference off three
                break
            }
        }
        
        return Int(pow(Double(2), Double(count)))*/
        0
    }
}

extension Day10 {
    private func calculateDifferences() -> [Int] {
        zip(allAdapters.prefix(upTo: allAdapters.count - 1), allAdapters.suffix(from: 1))
            .map { $0.1 - $0.0 }
    }
}
