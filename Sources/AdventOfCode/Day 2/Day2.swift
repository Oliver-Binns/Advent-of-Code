struct Day2: Solution {
    static let day = 2
    
    private let input: [String]
    

    init(input: String) {
        self.input = input
            .components(separatedBy: .newlines)
            .filter { !$0.isEmpty }
    }

    func calculatePartOne() -> Int {
        gamesPartOne
            .map(\.score)
            .reduce(0, +)
    }
    
    func calculatePartTwo() -> Int {
        gamesPartTwo
            .map(\.score)
            .reduce(0, +)
    }
}

extension Day2 {
    var gamesPartOne: [RPSGame] {
        input.map {
            $0
                .components(separatedBy: .whitespaces)
                .compactMap(RPSMove.init)
        }.map {
            RPSGame(opposingMove: $0[0], yourMove: $0[1])
        }
    }
    
    
    var gamesPartTwo: [RPSGame] {
        input.compactMap {
            let components = $0
                .components(separatedBy: .whitespaces)
            
            guard let move = RPSMove(rawValue: components[0]),
                  let outcome = RPSOutcome(rawValue: components[1]) else {
                return nil
            }
            return (move, outcome)
        }.map { (move, outcome) in
            RPSGame(opposingMove: move, result: outcome)
        }
    }
}

