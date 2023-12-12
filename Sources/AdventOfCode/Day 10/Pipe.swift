enum Pipe: Character, CaseIterable {
    case vertical = "|"
    case horizontal = "-"
    case northEast = "L"
    case northWest = "J"
    case southEast = "F"
    case southWest = "7"
    case ground = "."
    case start = "S"
}

extension Pipe {
    func connectedPipes(forCoordinate c: Coordinate) -> Set<Coordinate> {
        switch self {
        case .vertical:
            return [ c.up, c.down ]
        case .horizontal:
            return [ c.left, c.right ]
        case .northEast:
            return [ c.up, c.right ]
        case .northWest:
            return [ c.up, c.left ]
        case .southEast:
            return [ c.down, c.right ]
        case .southWest:
            return [ c.down, c.left ]
        case .ground, .start:
            return []
        }
    }
}
