struct Terrain {
    let coordinates: [Coordinate]
    
    init() {
        self.init(coordinates: [Coordinate(x: 0, y: 0)])
    }
    
    private init(coordinates: [Coordinate]) {
        self.coordinates = coordinates
    }
    
    func dig(instruction: DigInstruction) -> Terrain {
        let currentLocation = coordinates.last ?? Coordinate(x: 0, y: 0)
        return Terrain(coordinates: coordinates +
                       [nextPoint(after: currentLocation, instruction: instruction)])
    }
    
    private func nextPoint(after coordinate: Coordinate,
                           instruction: DigInstruction) -> Coordinate {
        switch instruction.direction {
        case .up:
            return Coordinate(x: coordinate.x,
                              y: coordinate.y - instruction.distance - 1)
        case .right:
            return Coordinate(x: coordinate.x + instruction.distance + 1,
                              y: coordinate.y)
        case .left:
            return Coordinate(x: coordinate.x - instruction.distance - 1,
                              y: coordinate.y)
        case .down:
            return Coordinate(x: coordinate.x,
                              y: coordinate.y + instruction.distance + 1)
        }
    }
    
    var cubicMeters: Int {
        let xs = coordinates.map({ $0.x })
        let ys = coordinates.map({ $0.y })
        
        let overlace = zip(xs, ys.dropFirst() + ys.prefix(1))
            .map({ $0.0 * $0.1 })
            .reduce(0, +)
        
        let underlace = zip(ys, xs.dropFirst() + xs.prefix(1))
            .map({ $0.0 * $0.1 })
            .reduce(0, +)

        return abs(overlace - underlace) / 2
    }
}
