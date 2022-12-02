enum RPSMove: Int, Equatable {
    case rock = 1
    case paper = 2
    case scissors = 3
    
    init?(rawValue: String) {
        switch rawValue {
        case "A", "X":
            self = .rock
        case "B", "Y":
            self = .paper
        case "C", "Z":
            self = .scissors
        default:
            preconditionFailure("Unexpected input")
        }
    }
}
