struct Day3: Solution {
    static let day = 3

    let instructions: [Instruction]

    init(input: String) {
        let stopRegex = /don't\(\)/
        let startRegex = /do\(\)/

        let rangesOfStop = input.ranges(of: stopRegex)
        let stopInstructions = Dictionary(
            rangesOfStop.map { ($0, Instruction.dont)},
            uniquingKeysWith: { $1 }
        )

        let rangesOfStart = input.ranges(of: startRegex)
        let startInstructions = Dictionary(
            rangesOfStart.map { ($0, Instruction.do)},
            uniquingKeysWith: { $1 }
        )

        let regex = /mul\((?<left>\d+),(?<right>\d+)\)/
        let matches = input.matches(of: regex)
        let multiplyInstructions: [Range<String.Index>: Instruction] = Dictionary(
            matches.compactMap { match in
                guard let left = Int(match.output.left),
                      let right = Int(match.output.right) else {
                    return nil
                }
                return (match.range, .multiply(left, right))
            },
            uniquingKeysWith: { $1 }
        )

        let allInstructions: [Range<String.Index>: Instruction] = startInstructions
            .merging(stopInstructions, uniquingKeysWith: { $1 })
            .merging(multiplyInstructions, uniquingKeysWith: { $1 })

        instructions = allInstructions.keys
            .sorted { $0.lowerBound < $1.lowerBound }
            .reduce([]) {
                guard let instruction = allInstructions[$1] else {
                    return $0
                }
                return $0 + [instruction]
            }
    }
    
    func calculatePartOne() -> Int {
        instructions
            .map(\.value)
            .reduce(0, +)
    }
    
    func calculatePartTwo() -> Int {
        instructions
            .reduce((count: 0, state: true)) { partialResult, instruction in
                switch instruction {
                case .do:
                    return (count: partialResult.count, state: true)
                case .dont:
                    return (count: partialResult.count, state: false)
                case .multiply(let left, let right) where partialResult.state:
                    let newCount = partialResult.count + (left * right)
                    return (count: newCount, state: partialResult.state)
                default:
                    return partialResult
                }
            }
            .count
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
