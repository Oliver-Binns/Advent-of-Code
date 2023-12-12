struct Coordinate: Equatable, Hashable {
    let x: Int
    let y: Int
}

extension Coordinate {
    var adjacentCoordinates: Set<Coordinate> {
        Set([
            Coordinate(x: x - 1, y: y),
            Coordinate(x: x, y: y - 1),
            Coordinate(x: x, y: y + 1),
            Coordinate(x: x + 1, y: y),
        ])
    }

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

extension Coordinate {
    var up: Coordinate {
        Coordinate(x: x, y: y - 1)
    }
    
    var down: Coordinate {
        Coordinate(x: x, y: y + 1)
    }
    
    var left: Coordinate {
        Coordinate(x: x - 1, y: y)
    }
    
    var right: Coordinate {
        Coordinate(x: x + 1, y: y)
    }
}
