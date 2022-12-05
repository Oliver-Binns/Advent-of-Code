import Algorithms
import DequeModule

struct Day5: Solution {
    static let day = 5
    
    let stacks: [Deque<String>]
    let instructions: [Instruction]
    
    init(input: String) {
        let (stacks, instructions) = Self.parse(input: input)
        self.stacks = stacks
        self.instructions = instructions
    }
    
    func calculatePartOne() -> String {
        instructions.reduce(stacks) { stacks, nextInstruction in
            var nextState = stacks
            
            (0..<nextInstruction.count).compactMap { _ in
                nextState[nextInstruction.origin - 1].popLast()
            }.forEach {
                nextState[nextInstruction.destination - 1]
                    .append($0)
            }
            
            return nextState
        }.compactMap { $0.last }.joined()
    }
    
    func calculatePartTwo() -> String {
        instructions.reduce(stacks) { stacks, nextInstruction in
            var nextState = stacks
            
            (0..<nextInstruction.count).compactMap { _ in
                nextState[nextInstruction.origin - 1].popLast()
            }.reversed().forEach {
                nextState[nextInstruction.destination - 1]
                    .append($0)
            }
            
            return nextState
        }.compactMap { $0.last }.joined()
    }
}

struct Instruction: Equatable {
    let count: Int
    let origin: Int
    let destination: Int
    
    init?(input: String) {
        let values = input
            .components(separatedBy: .whitespaces)
            .compactMap(Int.init)
        count = values[0]
        origin = values[1]
        destination = values[2]
    }
    
    init(count: Int,
         origin: Int,
         destination: Int) {
        self.count = count
        self.origin = origin
        self.destination = destination
    }
}

extension Day5 {
    static func parse(input: String) -> ([Deque<String>], [Instruction]) {
        let split = input.components(separatedBy: "\n\n")
        return (
            parseCrates(input: split[0]),
            parseInstructions(input: split[1])
        )
    }
    
    static func parseCrates(input: String) -> [Deque<String>] {
        let rows = input.components(separatedBy: .newlines)
        guard let count = rows.last?
            .components(separatedBy: .whitespaces)
            .compactMap(Int.init).last else {
            preconditionFailure("Invalid input format")
        }
        var crates = (0..<count).map { _ in
            Deque<String>()
        }
        
        rows.reversed()
            .suffix(from: 1)
            .forEach {
                $0
                    .chunks(ofCount: 4)
                    .map { $0.filter(\.isLetter) }
                    .enumerated()
                    .filter(!\.element.isEmpty)
                    .forEach {
                        crates[$0.offset].append($0.element)
                    }
                
            }
            
        return crates
    }
    
    static func parseInstructions(input: String) -> [Instruction] {
        input
            .components(separatedBy: .newlines)
            .filter(!\.isEmpty)
            .compactMap(Instruction.init)
    }
}

prefix func !<T>(keyPath: KeyPath<T, Bool>) -> (T) -> Bool {
    return { !$0[keyPath: keyPath] }
}
