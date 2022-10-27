final class Day14: Solution {
    let day = 14
    let instructions: [Instruction]
    
    init(input: String) {
        instructions = input
            .split(whereSeparator: { $0.isNewline })
            .map(String.init)
            .compactMap {
                Instruction(rawValue: $0)
            }
    }
    
    func calculatePartOne() -> Int {
        performCalculation(with: InitialisationPart1.self)
        
    }
    
    func calculatePartTwo() -> Int {
        performCalculation(with: InitialisationPart2.self)
    }
    
    func performCalculation(with type: Initialisation.Type) -> Int {
        instructions
            .reduce(into: type.init()) {
                $0.apply(instruction: $1)
            }
            .sum
    }
}

protocol Initialisation {
    var memory: [Int: Int] { get }
    init()
    mutating func apply(instruction: Instruction)
}

extension Initialisation {
    var sum: Int {
        memory.values.reduce(0, +)
    }
}

enum Instruction: Equatable {
    case mask(Mask)
    case write(Write)
    
    init?(rawValue: String) {
        let lines = rawValue
            .filter { !$0.isWhitespace }
            .split(separator: "=")
            .map(String.init)
        
        if lines[0].starts(with: "mask") {
            self = .mask(.init(string: lines[1]))
        } else if lines[0].starts(with: "mem"),
            let address = Int(lines[0].filter { $0.isNumber }),
            let value = Int(lines[1]) {
            self = .write(.init(address: address, value: value))
        } else {
            return nil
        }
    }
}

struct Write: Equatable {
    let address: Int
    let value: Int
}

struct Mask: Equatable {
    let values: [Int?]
   
    init(string: String = .init()) {
        values = string.map {
            switch $0 {
            case "0":
                return 0
            case "1":
                return 1
            default:
                return nil
            }
        }
    }
}

protocol MaskApplicator {
    static func apply(mask: Mask, to value: Int) -> Int
}
