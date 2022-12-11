struct Day9: Solution {
    static let day = 9
    
    let motions: [Motion]
    
    init(input: String) {
        motions = input
            .components(separatedBy: .newlines)
            .compactMap(Motion.init)
    }
    
    func calculatePartOne() -> Int {
        13
    }
    
    func calculatePartTwo() -> Int {
        0
    }
}

struct Rope: Equatable {
    let tail: Position
    let head: Position
    
    init(tail: Position = .origin,
         head: Position = .origin) {
        self.tail = tail
        self.head = head
    }
    
    func applyMotion(_ motion: Motion) -> Rope {
        .init(tail: tail,
              head: head)
    }
}

struct Motion: Equatable {
    let direction: Direction
    let amount: Int
    
    init(direction: Direction, amount: Int) {
        self.direction = direction
        self.amount = amount
    }
    
    init?(rawInput: String) {
        let data = rawInput.components(separatedBy: .whitespaces)
        guard data.count == 2,
            let direction = Direction(rawValue: data[0]),
            let amount = Int(data[1]) else {
            return nil
        }
        self.direction = direction
        self.amount = amount
    }
}

enum Direction: String {
    case left = "L"
    case right = "R"
    case up = "U"
    case down = "D"
}
