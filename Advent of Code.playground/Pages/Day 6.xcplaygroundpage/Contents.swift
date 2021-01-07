//: [Previous](@previous)
import Cocoa

guard let fileURL = Bundle.main
        .url(forResource: "Customs Forms", withExtension: nil),
      let fileContents = try? String(contentsOf: fileURL) else {
    preconditionFailure("Could not decode input data")
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

let formResponses = fileContents.components(separatedBy: "\n\n")

let formResponseCount = formResponses
    .map { $0.filter { $0.isLetter }.removingDuplicates() }
    .map { $0.count }
    .reduce(0, +)

print("Challenge 1 Solution: \(formResponseCount)")

let formResponseCount2 = formResponses
    .map { $0.split(whereSeparator: { $0.isNewline }).map(String.init) }
    .map { $0.map(Set.init) }
    .compactMap {
        $0.suffix(from: 1).reduce($0.first) { intersection, nextSet in
            intersection?.intersection(nextSet)
        }
    }
    .map { $0.count }
    .reduce(0, +)

print("Challenge 2 Solution: \(formResponseCount2)")
//: [Next](@next)
