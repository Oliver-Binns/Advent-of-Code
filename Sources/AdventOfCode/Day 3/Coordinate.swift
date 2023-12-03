struct Coordinate: Equatable, Hashable {
    let x: Int
    let y: Int
}

extension Coordinate {
    var surroundingCoordinates: Set<Coordinate> {
        Set([
            Coordinate(x: x - 1, y: y - 1),
            Coordinate(x: x - 1, y: y),
            Coordinate(x: x - 1, y: y + 1),
            
            Coordinate(x: x, y: y - 1),
            Coordinate(x: x, y: y + 1),
            
            Coordinate(x: x + 1, y: y - 1),
            Coordinate(x: x + 1, y: y),
            Coordinate(x: x + 1, y: y + 1),
        ])
    }
}
