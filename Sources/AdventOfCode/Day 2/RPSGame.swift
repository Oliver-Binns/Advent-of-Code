struct RPSGame: Equatable {
    let opposingMove: RPSMove
    let yourMove: RPSMove
    let result: RPSOutcome
    
    var score: Int {
        yourMove.rawValue + result.rawValue
    }
    
    init(opposingMove: RPSMove, yourMove: RPSMove) {
        self.yourMove = yourMove
        self.opposingMove = opposingMove
        self.result = Self.play(yourMove: yourMove, against: opposingMove)
    }
    
    init(opposingMove: RPSMove, result: RPSOutcome) {
        self.opposingMove = opposingMove
        self.result = result
        self.yourMove = Self.achieveOutcome(result, against: opposingMove)
    }
}

extension RPSGame {
    fileprivate static func play(yourMove: RPSMove,
                                 against opposingMove: RPSMove) -> RPSOutcome {
        guard yourMove != opposingMove else {
            return .draw
        }
        
        switch (yourMove, opposingMove) {
        case (.rock, .scissors),
             (.paper, .rock),
             (.scissors, .paper):
            return .win
        default:
            return .lose
        }
    }
    
    fileprivate static func achieveOutcome(_ outcome: RPSOutcome,
                                           against move: RPSMove) -> RPSMove {
        switch (move, outcome) {
        case (.paper, .lose),
             (.rock, .draw),
             (.scissors, .win):
            return .rock
        case (.paper, .draw),
             (.rock, .win),
             (.scissors, .lose):
            return .paper
        case (.paper, .win),
             (.scissors, .draw),
             (.rock, .lose):
            return .scissors
        }
    }
}
