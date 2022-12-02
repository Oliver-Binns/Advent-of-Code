enum RPSOutcome: Int, Equatable {
    case lose = 0
    case draw = 3
    case win = 6
    
    init?(rawValue: String) {
        switch rawValue {
        case "X":
            self = .lose
        case "Y":
            self = .draw
        case "Z":
            self = .win
        default:
            preconditionFailure("Unexpected input")
        }
    }
}
