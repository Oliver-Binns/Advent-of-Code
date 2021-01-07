//: [Previous](@previous)
import Cocoa

guard let fileURL = Bundle.main
        .url(forResource: "Program Code", withExtension: nil),
      let fileContents = try? String(contentsOf: fileURL) else {
    preconditionFailure("Could not decode input data")
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

let program = fileContents
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

let runProgram = { (program: [Line]) -> (CompletionState, Int) in
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

print("Challenge 1 Solution: \(runProgram(program).1)")

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

let fixedProgram = program
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

guard let fixedProgram = fixedProgram else {
    preconditionFailure("None of the solutions terminated correctly")
}
print("Challenge 2 Solution: \(fixedProgram.1)")

//: [Next](@next)
