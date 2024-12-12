struct Point: Hashable {
    let x: Int
    let y: Int
}

extension Point {
    func move(distance: Int = 1, in direction: Direction) -> Point {
        switch direction {
        case .north:
            Point(x: x, y: y-distance)
        case .northEast:
            Point(x: x+distance, y: y-distance)
        case .east:
            Point(x: x+distance, y: y)
        case .southEast:
            Point(x: x+distance, y: y+distance)
        case .south:
            Point(x: x, y: y+distance)
        case .southWest:
            Point(x: x-distance, y: y+distance)
        case .west:
            Point(x: x-distance, y: y)
        case .northWest:
            Point(x: x-distance, y: y-distance)
        }
    }
}

extension Point {
    var neighbours: [Point] {
        [Direction.north, .east, .south, .west]
            .map { move(in: $0) }
    }
}
