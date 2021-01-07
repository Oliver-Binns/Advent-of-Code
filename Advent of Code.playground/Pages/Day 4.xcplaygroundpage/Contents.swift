//: [Previous](@previous)
import Cocoa

guard let fileURL = Bundle.main
        .url(forResource: "Documentation", withExtension: nil),
      let fileContents = try? String(contentsOf: fileURL) else {
    preconditionFailure("Could not decode input data")
}

struct IdentityDocument {
    let identity: [Data: String]

    enum Data: String, CaseIterable {
        case birthYear = "byr"
        case issueYear = "iyr"
        case expirationYear = "eyr"
        case height = "hgt"
        case hairColour = "hcl"
        case eyeColour = "ecl"
        case passportID = "pid"
        case countryID = "cid"
    }

    init(rawInput: String) {
        identity = rawInput
            .split(whereSeparator: { $0.isWhitespace })
            .map { $0.split(separator: ":").map(String.init) }
            .reduce(into: [Data: String]()) { dictionary, newData in
                guard newData.count == 2,
                      let rawDataType = newData.first,
                      let dataType = Data(rawValue: rawDataType) else {
                    return
                }
                dictionary[dataType] = newData[1]
            }
    }

    var isValidChallenge1: Bool {
        Data.allCases
            .filter { $0 != .countryID }
            .allSatisfy { identity.keys.contains($0) }
    }
}

let documents = fileContents
    .components(separatedBy: "\n\n")
    .compactMap(IdentityDocument.init)

print("Challenge 1 Solution:", documents.filter { $0.isValidChallenge1 }.count)


enum EyeColour: String {
    case amber = "amb"
    case blue = "blu"
    case brown = "brn"
    case grey = "gry"
    case green = "grn"
    case hazel = "hzl"
    case other = "oth"
}

extension IdentityDocument {
    var isValidChallenge2: Bool {
        isValidChallenge1 && isAllDataValid
    }

    var isAllDataValid: Bool {
        identity.allSatisfy {
            $0.key.isValid(value: $0.value)
        }
    }
}

extension IdentityDocument.Data {
    func isValid(value: String) -> Bool {
        switch self {
        case .birthYear:
            guard let intValue = Int(value) else {
                return false
            }
            return (1920...2002).contains(intValue)
        case .issueYear:
            guard let intValue = Int(value) else {
                return false
            }
            return (2010...2020).contains(intValue)
        case .expirationYear:
            guard let intValue = Int(value) else {
                return false
            }
            return (2020...2030).contains(intValue)
        case .height:
            let suffixIndex = value.index(value.endIndex, offsetBy: -2)
            guard let height = Int(String(value.prefix(upTo: suffixIndex))) else {
                return false
            }
            if value.hasSuffix("cm") {
                return (150...193).contains(height)
            } else if value.hasSuffix("in") {
                return (59...76).contains(height)
            }
            return false
        case .hairColour:
            let regex = try! NSRegularExpression(pattern: "^#[a-f0-9]{6}$", options: [])
            let range = NSRange(location: 0, length: value.utf16.count)
            return regex.firstMatch(in: value, options: [], range: range) != nil
        case .eyeColour:
            return EyeColour(rawValue: value) != nil
        case .passportID:
            return value.allSatisfy { $0.isNumber } &&
                value.count == 9
        case .countryID:
            return true
        }
    }
}

print("Challenge 2 Solution:", documents.filter { $0.isValidChallenge2 }.count)
//: [Next](@next)
