struct PipeMap {
    private let pipes: [[Pipe]]
    let startLocation: Coordinate
    
    enum State: Character {
        case visited = "."
        case notVisited = " "
    }
    
    init(rawValue: String) {
        var map = rawValue
            .components(separatedBy: .newlines)
            .filter(\.isNotEmpty)
            .map {
                $0.compactMap(Pipe.init)
            }
        
        let startLocation: Coordinate = map.enumerated().compactMap { rowIndex, row in
            guard let columnIndex = row.firstIndex(where: { $0 == .start }) else {
                return nil
            }
            return Coordinate(x: columnIndex, y: rowIndex)
        }[0]
        
        let connectedToStart = startLocation.adjacentCoordinates.filter { coordinate in
            guard (0..<map.count).contains(coordinate.y),
                  (0..<map[0].count).contains(coordinate.x) else {
                return false
            }
            return map[coordinate.y][coordinate.x]
                .connectedPipes(forCoordinate: coordinate)
                .contains(startLocation)
        }
        
        guard let startPipe = Pipe.allCases.first(where: {
            $0.connectedPipes(forCoordinate: startLocation) == connectedToStart
        }) else { preconditionFailure("Unable to determine type of startPipe") }
        
        map[startLocation.y][startLocation.x] = startPipe
        
        self.init(startLocation: startLocation, pipes: map)
    }
    
    init(startLocation: Coordinate, pipes: [[Pipe]]) {
        self.startLocation = startLocation
        self.pipes = pipes
    }
    
    func calculateFurthestPosition() -> Int {
        let (length, _) = findLoop()
        return length
    }
    
    func calculateEnclosedTiles() -> Int {
        let (_, visitedLocations) = findLoop()
        
        return visitedLocations.map {
            $0
                .enumerated()
                .filter { $0.element == .visited }
                .map(\.offset)
                .chunked(into: 2)
                .map {
                    guard let last = $0.last,
                          let first = $0.first else {
                        preconditionFailure("Odd number of pipes in row")
                    }
                    return max(last - first - 1, 0)
                }
                .reduce(0, +)
        }.reduce(0, +)
    }
    
    func findLoop() -> (Int, [[State]]) {
        var step: Int = 0
        
        var state = pipes.map { $0.map { _ in State.notVisited } }
        state[startLocation.y][startLocation.x] = .visited
        
        var toVisit = pipes[startLocation.y][startLocation.x]
            .connectedPipes(forCoordinate: startLocation)
        
        
        while toVisit.isNotEmpty {
            // update step
            step += 1
            
            // update pipes to visited
            toVisit.forEach {
                state[$0.y][$0.x] = .visited
            }
            
            // find next pipes!
            toVisit = toVisit.reduce(into: []) { set, location in
                pipes[location.y][location.x]
                    .connectedPipes(forCoordinate: location)
                    .filter { state[$0.y][$0.x] == .notVisited }
                    .forEach {
                        set.insert($0)
                    }
            }
        }
        
        return (step, state)
    }
}

extension PipeMap: CustomStringConvertible {
    var description: String {
        pipes.map {
            $0.map(\.rawValue)
                .map(String.init)
                .joined()
        }.joined(separator: "\n")
    }
}
