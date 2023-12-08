struct Day8: Solution {
    static let day = 8
    
    let instructions: [Instruction]
    let map: [String: Node]
    
    init(input: String) {
        let parts = input.split(separator: "\n\n")
        
        instructions = parts[0]
            .compactMap(Instruction.init)
        
        map = parts[1]
            .components(separatedBy: .newlines)
            .filter { !$0.isEmpty }
            .map(parseNode)
            .reduce(into: [:]) {
                $0[$1.0] = $1.1
            }
    }
    
    func calculatePartOne() -> Int {
        var currentLocation = "AAA"
        var stepCount = 0
        
        while currentLocation != "ZZZ" {
            for instruction in instructions {
                stepCount += 1
                
                switch instruction {
                case .left:
                    currentLocation = map[currentLocation]!.left
                case .right:
                    currentLocation = map[currentLocation]!.right
                }
                
                if currentLocation == "ZZZ" {
                    return stepCount
                }
            }
        }
        
        return stepCount
    }
    
    func calculatePartTwo() -> Int {
        0
    }
}

enum Instruction: Character {
    case left = "L"
    case right = "R"
}

struct Node: Equatable {
    let left: String
    let right: String
}

func parseNode(input: String) -> (String, Node) {
    let data = Array(input.filter(\.isLetter))
        .chunked(into: 3)
        .map { String($0) }
    
    return (
        data[0],
        Node(left: data[1], right: data[2])
    )
}
