import Foundation

struct Day2 {
    let day = 2
    let passwords: [PasswordPolicy]
    
    init(input: String) {
        self.passwords = input
            .split(whereSeparator: { $0.isNewline })
            .map(String.init)
            .map { $0.split(whereSeparator: { $0.isWhitespace })}
            .compactMap { $0.compactMap(String.init) }
            .compactMap(PasswordPolicy.init)
    }
}

extension Day2: Solution {
    func calculatePartOne() -> String {
        passwords.filter { $0.isValidForChallenge1 }.count.description
    }
    
    func calculatePartTwo() -> String {
        passwords.filter { $0.isValidForChallenge2 }.count.description
    }
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
