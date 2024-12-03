struct Day3: Solution {
    static let day = 3

    let instructions: [Instruction]

    init(input: String) {
        let regex = /mul\((?<left>\d+),(?<right>\d+)\)/
        let matches = input.matches(of: regex)

        instructions = matches.compactMap { match in
            guard let left = Int(match.output.left),
                  let right = Int(match.output.right) else {
                return nil
            }
            return .multiply(left, right)
        }
    }
    
    func calculatePartOne() -> Int {
        instructions
            .map(\.value)
            .reduce(0, +)
    }
    
    func calculatePartTwo() -> Int {
        0
    }
}

extension Day3 {
    enum Instruction: Equatable {
        case `do`
        case dont
        case multiply(Int, Int)
    }
}

extension Day3.Instruction {
    var value: Int {
        switch self {
        case .multiply(let a, let b):
            return a * b
        default:
            return 0
        }
    }
}
