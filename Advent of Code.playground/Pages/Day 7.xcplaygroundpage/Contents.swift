//: [Previous](@previous)
import Cocoa

guard let fileURL = Bundle.main
        .url(forResource: "Bag Restrictions", withExtension: nil),
      let fileContents = try? String(contentsOf: fileURL) else {
    preconditionFailure("Could not decode input data")
}

extension String {
    func removingSuffix(_ suffix: String) -> Self {
        hasSuffix(suffix) ? removingSuffix(suffix.count) : self
    }

    func removingSuffix(_ length: Int) -> Self {
        let startIndex = index(endIndex, offsetBy: -length)
        return Self(prefix(upTo: startIndex))
    }
}

let restrictions = fileContents
    .split(whereSeparator: { $0.isNewline })
    .map(String.init)
    .map { $0.components(separatedBy: " bags contain ")}
    .reduce(into: [String: [String: Int]]()) { dictionary, newValue in
        guard newValue.count == 2,
            let bagName = newValue.first,
            let allowedContents = newValue.last else {
            return
        }
        dictionary[bagName] = allowedContents
            .components(separatedBy: ", ")
            .map {
                $0.split(maxSplits: 1, whereSeparator: { $0.isWhitespace })
                    .map(String.init)
                    .map { $0.trimmingCharacters(in: .punctuationCharacters) }
                    .map { $0.removingSuffix("bags") }
                    .map { $0.removingSuffix("bag") }
                    .map { $0.trimmingCharacters(in: .whitespaces) }
            }
            .reduce(into: [String: Int]()) { dictionary, bagCount in
                guard bagCount.count == 2,
                      let count = Int(bagCount[0]) else { return }
                dictionary[bagCount[1]] = count
            }

    }



func bag(_ outerBag: String, canContain innerBag: String) -> Bool {
    guard let allowedContents = restrictions[outerBag]?.keys else {
        return false
    }
    return allowedContents.contains(innerBag) || allowedContents.contains(where: {
        bag($0, canContain: innerBag)
    })
}

let myBag = "shiny gold"
let bagCount = restrictions.keys
    .map {
        bag($0, canContain: myBag)
    }
    .map {
        $0 ? 1 : 0
    }
    .reduce(0, +)

print("Challenge 1 Solution: \(bagCount)")

func bagMustContain(_ bag: String) -> Int {
    guard let allowedContents = restrictions[bag] else {
        return 0
    }
    return allowedContents.map { key, value -> Int in
        value * (1 + bagMustContain(key))
    }.reduce(0, +)
}

print("Challenge 2 Solution: \(bagMustContain(myBag))")
//: [Next](@next)
