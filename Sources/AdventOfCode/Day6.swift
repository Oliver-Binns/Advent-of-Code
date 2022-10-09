import Foundation

struct Day6 {
    let day = 6
    let responses: [String]
    
    init(input: String) {
        responses = input.components(separatedBy: "\n\n")
    }
}

extension Day6: Solution {
    func calculatePartOne() -> String {
        responses
            .map { $0.filter { $0.isLetter }.removingDuplicates() }
            .map { $0.count }
            .reduce(0, +)
            .description
    }
    
    func calculatePartTwo() -> String {
        responses
            .map { $0.split(whereSeparator: { $0.isNewline }).map(String.init) }
            .map { $0.map(Set.init) }
            .compactMap {
                $0.suffix(from: 1).reduce($0.first) { intersection, nextSet in
                    intersection?.intersection(nextSet)
                }
            }
            .map { $0.count }
            .reduce(0, +)
            .description
    }
}

extension Array where Element: Hashable {
    func removingDuplicates() -> Self {
        var addedDict = [Element: Bool]()
        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }

    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}
