struct Day10: Solution {
    static let day = 10
    
    let instructions: [Instruction]
    let allStates: [CPU]
    
    init(input: String) {
        self.instructions = input
            .components(separatedBy: .newlines)
            .compactMap(Instruction.init)
        self.allStates = instructions.reduce([CPU()]) { partialResult, instruction in
           guard let previousState = partialResult.last else {
               preconditionFailure("Unknown previous state")
           }
           return partialResult + previousState
               .runInstruction(instruction)
        }
    }
    
    func calculatePartOne() -> Int {
        [20, 60, 100, 140, 180, 220].map {
            // N.B. negative one because we want the value
            // _during_ not _after_ the run
            allStates[$0 - 1].register * $0
        }.reduce(0, +)
    }
    
    func calculatePartTwo() -> String {
        "\n\n" + (0..<6).map { row in
            (0..<40).map { column in
                getState(row: row, column: column)
            }.joined()
        }.joined(separator: "\n")
    }
    
    func getState(row: Int, column: Int) -> String {
        let cycle = row * 40 + column
        let registerValue = allStates[cycle].register
        let spriteRange = (registerValue-1)...(registerValue+1)
        
        if spriteRange.contains(column) {
            return "#"
        } else {
            return "."
        }
    }
}

extension Day10 {
    struct CPU {
        let register: Int
        
        init(register: Int = 1) {
            self.register = register
        }
        
        func runInstruction(_ instruction: Instruction) -> [CPU] {
            switch instruction {
            case .noOperation:
                return [self]
            case .add(let x):
                return [self, CPU(register: register + x)]
            }
        }
    }

    enum Instruction: Equatable {
        case noOperation
        case add(Int)
        
        init?(rawValue: String) {
            let components = rawValue
                .components(separatedBy: .whitespaces)
            
            guard components.count > 0 else { return nil }
            
            switch components[0] {
            case "noop":
                self = .noOperation
            case "addx" where components.count > 1:
                guard let value = Int(components[1]) else {
                    return nil
                }
                self = .add(value)
            default:
                return nil
            }
        }
    }
}
