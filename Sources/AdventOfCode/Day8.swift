import Foundation

typealias Program = [Line]

struct Day8 {
    let day = 8
    let program: Program
    
    init(input: String) {
        program = input
            .split(whereSeparator: { $0.isNewline })
            .map(String.init)
            .map { $0.split(whereSeparator: { $0.isWhitespace }) }
            .map { $0.map(String.init) }
            .map { (token: Token(rawValue: $0[0]), value: Int($0[1])) }
            .compactMap { (token: Token?, value: Int?) -> Line? in
                guard let token = token,
                      let value = value else {
                    return nil
                }
                return Line(token: token, value: value)
            }
    }
    
    func runProgram(_ program: Program) -> (CompletionState, Int) {
        var accumulator = 0
        var currentLine = 0
        var linesRun = Set<Int>()

        while currentLine < program.count {
            let instruction = program[currentLine]

            guard !linesRun.contains(currentLine) else {
                return (.infiniteLoop, accumulator)
            }
            linesRun.insert(currentLine)

            switch instruction.token {
            case .jump:
                currentLine += instruction.value
                continue
            case .accumulator:
                accumulator += instruction.value
            default:
                break
            }

            currentLine += 1
        }

        return (.terminated, accumulator)
    }
    
    func fixProgram() -> (CompletionState, Int)? {
        program
           .indexes(where: { $0.token != .accumulator })
           .lazy
           .map { index -> (CompletionState, Int) in
               var programCopy = program

               switch programCopy[index].token {
               case .jump:
                   programCopy[index] = Line(token: .noOperation,
                                             value: programCopy[index].value)
               case .noOperation:
                   programCopy[index] = Line(token: .jump,
                                             value: programCopy[index].value)
               default:
                   break
               }

               return runProgram(programCopy)
           }
           .first(where: { $0.0 == .terminated })
    }
}

extension Day8: Solution {
    func calculatePartOne() -> String {
        runProgram(program).1.description
    }
    
    func calculatePartTwo() -> String {
        guard let fixedProgram = fixProgram() else {
            preconditionFailure("None of the solutions terminated correctly")
        }
        return fixedProgram.1.description
    }
}

enum Token: String {
    case noOperation = "nop"
    case jump = "jmp"
    case accumulator = "acc"
}

struct Line {
    let token: Token
    let value: Int
}

enum CompletionState {
    case infiniteLoop
    case terminated
}

extension Array {
    func indexes(where condition: (Element) -> Bool) -> [Array.Index] {
        enumerated()
            .filter {
                condition($0.element)
            }
            .map {
                $0.offset
            }
    }
}
