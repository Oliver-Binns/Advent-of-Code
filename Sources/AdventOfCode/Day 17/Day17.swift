import Foundation

struct Day17: Solution {
    static let day = 17

    let initialState: ComputerState
    let program: [Int]

    init(input: String) {
        let regex = /Register A: (?<registerA>\d+)\nRegister B: (?<registerB>\d+)\nRegister C: (?<registerC>\d+)\n\nProgram: (?<program>[\d\,]+)\n/

        guard let match = try? regex.firstMatch(in: input),
              let registerA = Int(match.output.registerA),
              let registerB = Int(match.output.registerB),
              let registerC = Int(match.output.registerC) else {
            preconditionFailure("Non-matching input")
        }

        initialState = ComputerState(
            registerA: registerA,
            registerB: registerB,
            registerC: registerC
        )

        program = match.output.program.split(separator: ",")
            .map(String.init)
            .compactMap(Int.init)
    }
    
    func calculatePartOne() -> String {
        initialState
            .runProgram(program)
            .output
            .map(\.description)
            .joined(separator: ",")
    }

    func calculatePartTwo() -> Int {
        0
    }
}

struct ComputerState: Equatable {
    let registerA: Int
    let registerB: Int
    let registerC: Int

    let instructionPointer: Int

    let output: [Int]

    init(registerA: Int,
         registerB: Int,
         registerC: Int,
         instructionPointer: Int = 0,
         output: [Int] = []
    ) {
        self.registerA = registerA
        self.registerB = registerB
        self.registerC = registerC

        self.instructionPointer = instructionPointer

        self.output = output
    }

    func comboOperand(_ operand: Int) -> Int {
        switch operand {
        case 0...3:
            return operand
        case 4:
            return registerA
        case 5:
            return registerB
        case 6:
            return registerC
        default:
            preconditionFailure("Invalid program operand: \(operand)")
        }
    }

    func runInstruction(
        opcode: Instruction,
        operand: Int
    ) -> ComputerState {
        switch opcode {
        case .adv:
            let numerator = registerA
            let denominator = 2 ^^ comboOperand(operand)
            return self.updating(registerA: numerator / denominator)
        case .bdv:
            let numerator = registerA
            let denominator = 2 ^^ comboOperand(operand)
            return self.updating(registerB: numerator / denominator)
        case .cdv:
            let numerator = registerA
            let denominator = 2 ^^ comboOperand(operand)
            return self.updating(registerC: numerator / denominator)
        case .bxl:
            let bitwiseXOR = registerB ^ operand
            return self.updating(registerB: bitwiseXOR)
        case .bst:
            let modulo8 = comboOperand(operand) % 8
            return self.updating(registerB: modulo8)
        case .jnz:
            guard registerA != 0 else { return self.updating() }
            return self.updating(instructionPointer: operand)
        case .bxc:
            let bitwiseXOR = registerB ^ registerC
            return self.updating(registerB: bitwiseXOR)
        case .out:
            let output = comboOperand(operand) % 8
            return self.updating(output: output)
        }
    }

    func runProgram(_ program: [Int]) -> ComputerState {
        let programLength = program.count

        var state = self
        while state.instructionPointer < programLength,
              let opcode = Instruction(rawValue: program[state.instructionPointer]) {
            state = state.runInstruction(
                opcode: opcode,
                operand: program[state.instructionPointer + 1]
            )
        }

        return state
    }

    func updating(
        registerA: Int? = nil,
        registerB: Int? = nil,
        registerC: Int? = nil,
        instructionPointer: Int? = nil,
        output: Int? = nil
    ) -> ComputerState{
        ComputerState(
            registerA: registerA ?? self.registerA,
            registerB: registerB ?? self.registerB,
            registerC: registerC ?? self.registerC,
            instructionPointer: instructionPointer ?? (self.instructionPointer + 2),
            output: self.output + [output].compactMap { $0 }
        )
    }
}

enum Instruction: Int {
    case adv = 0
    case bxl = 1
    case bst = 2
    case jnz = 3
    case bxc = 4
    case out = 5
    case bdv = 6
    case cdv = 7
}

precedencegroup PowerPrecedence { higherThan: MultiplicationPrecedence }
infix operator ^^ : PowerPrecedence
func ^^ (radix: Int, power: Int) -> Int {
    return Int(pow(Double(radix), Double(power)))
}
