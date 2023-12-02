extension Day2 {
    typealias Round = [Cube: Int]
    
    struct Game: Equatable {
        let id: Int
        let rounds: [Round]
        
        init(id: Int, rounds: [Day2.Round]) {
            self.id = id
            self.rounds = rounds
        }
        
        init(string: String) {
            let parts = string
                .split(separator: ": ")
            
            guard let roundNumber = Int(parts[0].filter(\.isNumber)) else {
                preconditionFailure("Invalid game ID provided (should be integer): \(parts[0])")
            }
            id = roundNumber
            
            
            rounds = parts[1]
                .components(separatedBy: ";")
                .map { $0.filter { !$0.isWhitespace } }
                .map { round in
                    return round
                        .components(separatedBy: .punctuationCharacters)
                        .reduce(into: [:]) { dictionary, input in
                            guard let cube = Cube(rawValue: input.filter(\.isLetter)),
                                  let value = Int(input.filter(\.isNumber)) else {
                                preconditionFailure("Invalid color, \(input)")
                            }
                            dictionary[cube] = value
                        }
                }
                
        }
        
        var minCubes: [Cube: Int] {
            rounds.reduce(into: [Cube: Int]()) { maxValues, round in
                round.forEach { (cube, value) in
                    maxValues[cube] =
                        max(maxValues[cube, default: 0], value)
                }
            }
        }
        
        func isPossible(with cubes: [Cube: Int]) -> Bool {
            rounds.allSatisfy {
                $0.isPossible(with: cubes)
            }
        }
    }
    
    enum Cube: String {
        case red, green, blue
    }
}
