//: [Previous](@previous)
import Cocoa

guard let fileURL = Bundle.main
        .url(forResource: "Passwords", withExtension: nil),
      let fileContents = try? String(contentsOf: fileURL) else {
    preconditionFailure("Could not decode input data")
}

struct PasswordPolicy {
    let range: Range<Int>
    let character: Character
    let password: String
    let characterCount: Int

    init?(rawInput: [String]) {
        guard rawInput.count == 3,
              let character = rawInput[1].first else {
            return nil
        }
        let range = rawInput[0]
            .split(separator: "-")
            .map(String.init)
            .compactMap(Int.init)
        guard range.count == 2,
              let lowerBound = range.first,
              let upperBound = range.last else {
            return nil
        }

        self.range = .init(uncheckedBounds: (lower: lowerBound, upper: upperBound))
        self.character = character
        self.password = rawInput[2]
        self.characterCount = password.filter { $0 == character }.count
    }

    var isValidForChallenge1: Bool {
        characterCount >= range.lowerBound &&
            characterCount <= range.upperBound
    }
}

let passwords = fileContents
    .split(whereSeparator: { $0.isNewline })
    .map(String.init)
    .map { $0.split(whereSeparator: { $0.isWhitespace })}
    .compactMap { $0.compactMap(String.init) }
    .compactMap(PasswordPolicy.init)

print("Challenge 1 Solution:", passwords.filter { $0.isValidForChallenge1 }.count)

extension PasswordPolicy {
    var isValidForChallenge2: Bool {
        isCharacterAtIndexCorrect(index: range.lowerBound) !=
            isCharacterAtIndexCorrect(index: range.upperBound)
    }

    private func isCharacterAtIndexCorrect(index: Int) -> Bool {
        characterAtIndex(index) == character
    }

    private func characterAtIndex(_ index: Int) -> Character? {
        guard index <= password.count else {
            return nil
        }
        let stringIndex = password.index(password.startIndex,
                                         offsetBy: index - 1)
        return password[stringIndex]
    }
}

print("Challenge 2 Solution:", passwords.filter { $0.isValidForChallenge2 }.count)
//: [Next](@next)
