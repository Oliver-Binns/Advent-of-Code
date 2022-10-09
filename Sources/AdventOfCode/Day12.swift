final class Day12: Solution {
    let day = 12
    
    let instructions: [Instruction]
    
    init(input: String) {
        instructions = input
            .split(whereSeparator: { $0.isWhitespace })
            .map(String.init)
            .compactMap(Instruction.init)
    }
    
    func calculatePartOne() -> Int {
        instructions.reduce(Ship()) {
            $0.applyingInstruction($1)
        }.manhattanDistance
    }
    
    func calculatePartTwo() -> Int {
        0
    }
}

extension Day12 {
    struct Ship {
        let orientation: Direction
        let xPosition: Int
        let yPosition: Int
        
        init(orientation: Direction = .east,
             xPosition: Int = 0,
             yPosition: Int = 0) {
            self.orientation = orientation
            self.xPosition = xPosition
            self.yPosition = yPosition
        }
        
        var manhattanDistance: Int {
            abs(xPosition) + abs(yPosition)
        }
        
        func applyingInstruction(_ instruction: Instruction) -> Ship {
            switch instruction.direction {
            case .left, .right:
                return Ship(orientation: orientation.rotated(by: instruction),
                            xPosition: xPosition, yPosition: yPosition)
            case .north,
                 .forwards where orientation == .north:
                return Ship(orientation: orientation,
                            xPosition: xPosition,
                            yPosition: yPosition + instruction.amount)
            case .east,
                 .forwards where orientation == .east:
                return Ship(orientation: orientation,
                            xPosition: xPosition + instruction.amount,
                            yPosition: yPosition)
            case .south,
                 .forwards where orientation == .south:
                return Ship(orientation: orientation,
                            xPosition: xPosition,
                            yPosition: yPosition - instruction.amount)
            case .west,
                 .forwards where orientation == .west:
                return Ship(orientation: orientation,
                            xPosition: xPosition - instruction.amount,
                            yPosition: yPosition)
            default:
                return self
            }
        }
    }
    
    struct Instruction {
        let direction: Direction
        let amount: Int
        
        init?(string: String) {
            let rawAmount = string.suffix(from: string.index(after: string.startIndex))
            guard let rawDirection = string.first.flatMap(Character.init),
                  let direction = Direction(rawValue: rawDirection),
                  let amount = Int(rawAmount) else {
                return nil
            }
            self.direction = direction
            self.amount = amount
        }
        
        init(direction: Direction, amount: Int) {
            self.direction = direction
            self.amount = amount
        }
    }
    
    enum Direction: Character {
        case north = "N"
        case south = "S"
        case east = "E"
        case west = "W"
        
        case forwards = "F"
        case left = "L"
        case right = "R"
    }
}

extension Day12.Instruction: CustomStringConvertible {
    var description: String {
        "\(direction.rawValue)\(amount)"
    }
}

extension Day12.Direction {
    func rotated(by rotation: Day12.Instruction) -> Day12.Direction {
        var rotationAmount = rotation.amount
        
        switch rotation.direction {
        case .left:
            rotationAmount = 360 - rotationAmount
            fallthrough
        case .right:
            switch (self, rotationAmount) {
            case (.west, 90), (.south, 180), (.east, 270):
                return .north
            case (.north, 90), (.west, 180), (.south, 270):
                return .east
            case (.east, 90), (.north, 180), (.west, 270):
                return .south
            case (.south, 90), (.east, 180), (.north, 270):
                return .west
            default:
                break
            }
        default:
            break
        }
        
        preconditionFailure("Unexpected rotation attempt")
    }
}
