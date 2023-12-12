enum Spring: Character, Equatable {
    case operational = "."
    case damaged = "#"
    case unknown = "?"
}

extension Spring: ExpressibleByStringLiteral {
    init(stringLiteral value: String) {
        guard let character = value.first else {
            preconditionFailure("Can't initialise with empty string")
        }
        self.init(rawValue: character)!
    }
}

extension Spring: CustomStringConvertible {
    var description: String {
        rawValue.description
    }
}
