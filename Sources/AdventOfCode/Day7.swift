import Foundation

struct Day7 {
    let day = 7
    let myBag = "shiny gold"
    let restrictions: [String: [String: Int]]
    
    init(input: String) {
        restrictions = input
            .split(whereSeparator: { $0.isNewline })
            .map(String.init)
            .map { $0.components(separatedBy: " bags contain ") }
            .reduce(into: [String: [String: Int]](), Self.transform)
    }
    
    static func transform(dictionary: inout [String: [String: Int]], newValue: [String]) {
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
    
    func bagMustContain(_ bag: String) -> Int {
        guard let allowedContents = restrictions[bag] else {
            return 0
        }
        return allowedContents.map { key, value -> Int in
            value * (1 + bagMustContain(key))
        }.reduce(0, +)
    }
    
    func bag(_ outerBag: String, canContain innerBag: String) -> Bool {
        guard let allowedContents = restrictions[outerBag]?.keys else {
            return false
        }
        return allowedContents.contains(innerBag) || allowedContents.contains(where: {
            bag($0, canContain: innerBag)
        })
    }
}

extension Day7: Solution {
    func calculatePartOne() -> String {
        restrictions.keys
            .map {
                bag($0, canContain: myBag)
            }
            .map {
                $0 ? 1 : 0
            }
            .reduce(0, +)
            .description
    }
    
    func calculatePartTwo() -> String {
        bagMustContain(myBag).description
    }
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

