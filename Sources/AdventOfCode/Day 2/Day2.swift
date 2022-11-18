final class Day2: Solution {
    static let day = 2
    
    let program: ProgramState
    
    init(input: String) {
        program = .init(state: input
            .filter { !$0.isWhitespace }
            .components(separatedBy: ",")
            .compactMap(Int.init))
    }
    
    func calculatePartOne(replacingValues: Bool) -> Int {
        let program: ProgramState
        if replacingValues {
            var state = self.program.state
            state[1] = 12
            state[2] = 2
            program = .init(state: state)
        } else {
            program = self.program
        }
        
        return Computer().runProgram(program)[0]
    }

    func calculatePartOne() -> Int {
        calculatePartOne(replacingValues: true)
    }
    
    func calculatePartTwo() -> Int {
        0
    }
}

struct Computer {
    func runProgram(_ program: ProgramState) -> ProgramState {
        var instruction = 0
        var program = program
        
        while let nextProgram = program.runInstruction(instruction) {
            instruction += 4
            program = nextProgram
        }
        
        return program
    }
}

struct ProgramState {
    let state: [Int]
    
    subscript(index: Int) -> Int {
        state[index]
    }
    
    func runInstruction(_ instruction: Int) -> ProgramState? {
        let positionX = state[instruction + 1]
        let positionY = state[instruction + 2]
        let positionZ = state[instruction + 3]
        
        var newState = state
        
        switch state[instruction] {
        case 1:
            // 1, X, Y, Z -> subscript[Z] = subscript[X] + subscript[Y]
            newState[positionZ] = state[positionX] + state[positionY]
        case 2:
            // 2, X, Y, Z -> subscript[Z] = subscript[X] * subscript[Y]
            newState[positionZ] = state[positionX] * state[positionY]
        default:
            return nil
        }
        
        return .init(state: newState)
    }
}
