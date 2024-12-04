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
