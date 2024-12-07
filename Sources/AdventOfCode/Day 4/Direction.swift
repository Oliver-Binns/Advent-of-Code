enum Direction: CaseIterable {
    case north
    case northEast
    case east
    case southEast
    case south
    case southWest
    case west
    case northWest
}


extension Direction {
    static var diagonals: [Direction] {
        [.northEast, .northWest, .southEast, .southWest]
    }
}

extension Direction {
    func rotateClockwise() -> Direction {
        switch self {
        case .north: return .east
        case .east: return .south
        case .south: return .west
        case .west: return .north
        default: fatalError("Not implemented")
        }
    }
}
