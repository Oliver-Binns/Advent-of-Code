struct Day9: Solution {
    static let day = 9
    
    let motions: [Motion]
    
    init(input: String) {
        motions = input
            .components(separatedBy: .newlines)
            .compactMap(Motion.init)
    }
    
    func calculatePartOne() -> Int {
        run()
    }
    
    func calculatePartTwo() -> Int {
        run(ropeLength: 10)
    }
    
    func run(ropeLength: Int = 2) -> Int {
        motions.reduce([Rope(length: ropeLength)]) { ropes, motion in
            guard let lastRope = ropes.last else {
                preconditionFailure("Array should never be empty")
            }
            return ropes + lastRope.applyMotion(motion)
        }.reduce(Set<Position>()) { positions, rope in
            positions.union([rope.tail])
        }.count
    }
}

struct Rope: Equatable {
    let positions: [Position]
    var head: Position {
        positions.first!
    }
    var tail: Position {
        positions.last!
    }
    
    init(tail: Position, head: Position) {
        self.positions = [head, tail]
    }
    
    init(positions: [Position]) {
        self.positions = positions
    }
    
    init(length: Int = 2) {
        positions = (0..<length).map { _ in .origin }
    }
    
    private func move(direction: Direction) -> Rope {
        let newHead: Position
        
        switch direction {
        case .up:
            newHead = head.up
        case .down:
            newHead = head.down
        case .left:
            newHead = head.left
        case .right:
            newHead = head.right
        }
        
        return Rope(positions: positions
            .suffix(from: 1)
            .reduce([newHead]) { positions, nextKnot in
                guard let previousKnot = positions.last else {
                    preconditionFailure("Array should never be empty")
                }
                let distance = previousKnot.distanceFrom(position: nextKnot)
                let knotShouldMove = abs(distance.x) > 1 ||
                    abs(distance.y) > 1
                
                guard knotShouldMove else {
                    return positions + [nextKnot]
                }
                
                let xMove = min(max(distance.x, -1), 1)
                let yMove = min(max(distance.y, -1), 1)
                let newPosition = Position(x: xMove + nextKnot.x,
                                           y: yMove + nextKnot.y)
                
                return positions + [newPosition]
            })
    }
    
    func applyMotion(_ motion: Motion) -> [Rope] {
        (0..<motion.amount) // 0, 1, 2, 3
            .map { _ in motion.direction } // right, right, right, right
            .reduce([self]) { ropes, direction in
                guard let last = ropes.last else {
                    preconditionFailure("Array should never be empty")
                }
                return ropes + [last.move(direction: direction)]
            }
    }
}

extension Position {
    func distanceFrom(position: Position) -> Position {
        .init(x: x - position.x,
              y: y - position.y)
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
