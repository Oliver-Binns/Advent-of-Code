struct Day12: Solution {
    static let day = 12
    
    let map: Map
    
    init(input: String) {
        map = Map(input
            .components(separatedBy: .newlines)
            .map(Array.init)
            .filter(!\.isEmpty))
    }
    
    func calculatePartOne() -> Int {
        guard let startPosition = map.findPosition(of: "S"),
              let goal = map.findPosition(of: "E") else {
            preconditionFailure("Could not find end position")
        }
        var state = State(map: map, startPosition: startPosition)
        
        while true {
            if let routeLength = state.routes
                .filter({ $0.value.contains(goal) })
                .keys
                .min() {
                    return routeLength
                }
            state = state.iterate()
        }
    }
    
    func calculatePartTwo() -> Int {
        guard let startPosition = map.findPosition(of: "E") else {
            preconditionFailure("Could not find end position")
        }
        var state = State(map: map, startPosition: startPosition)
        
        while true {
            if let routeLength = state.routes
                .first(where: { (key, positions) in
                    positions.contains { position in
                        map[position.y][position.x].height ==
                            Character("a").asciiValue
                    }
                })?.key {
                    return routeLength
                }
            state = state.iterate(isClimbing: false)
        }
    }
}

extension Day12 {
    struct State: Equatable {
        let map: Map
        let visited: Set<Position>
        let routes: [Int: Set<Position>]
        
        init(map: Map = .init(),
             startPosition: Position) {
            self.map = map
            self.visited = [startPosition]
            self.routes = [0: [startPosition]]
        }
        
        init(map: Map = .init(),
             visited: Set<Position>,
             routes: [Int: Set<Position>]) {
            self.map = map
            self.visited = visited
            self.routes = routes
        }
        
        func iterate(isClimbing: Bool = true) -> State {
            var routes = self.routes
            guard let lowestValue = routes.keys.min(),
                  let position = routes[lowestValue]?.popFirst() else {
                preconditionFailure("expected a previous position")
            }
            
            let bestPosition = position
            // remove from the set
            // add next positions
            let newPositions = [
                bestPosition.up,
                bestPosition.down,
                bestPosition.left,
                bestPosition.right
            ]
            .filter { !visited.contains($0) }
            .filter { map.canMove(from: bestPosition, to: $0,
                                  isClimbing: isClimbing) }
            
            newPositions.forEach {
                routes[lowestValue + 1, default: []].insert($0)
            }
            
            if routes[lowestValue]!.isEmpty {
                routes.removeValue(forKey: lowestValue)
            }
            
            return .init(map: map,
                         visited: visited.union(newPositions),
                         routes: routes)
        }
    }
    
    struct Map: Equatable {
        private let map: [[Character]]
        
        let width: Int
        let height: Int
        
        subscript(index: Int) -> [Character] {
            map[index]
        }
        
        init(_ map: [[Character]] = []) {
            self.map = map
            self.width = map.first?.count ?? 0
            self.height = map.count
        }
        
        func isPositionInBounds(_ position: Position) -> Bool {
            position.x >= 0 && position.y >= 0 &&
                position.y < height && position.x < width
        }
        
        func canMove(from origin: Position,
                     to destination: Position,
                     isClimbing: Bool = true) -> Bool {
            guard isPositionInBounds(destination) else { return false }
            
            let originValue = map[origin.y][origin.x]
            let destinationValue = map[destination.y][destination.x]
            
            guard let originAscii = originValue.height,
                  let destinationAscii = destinationValue.height else {
                preconditionFailure("Expected cell to be ascii value")
            }
            return isClimbing ?
                Int(originAscii) - Int(destinationAscii) >= -1 :
                Int(destinationAscii) - Int(originAscii) >= -1
        }
        
        func findPosition(of character: Character) -> Position? {
            map.enumerated().compactMap { (y, row) in
                guard let x = row.firstIndex(of: character) else {
                    return nil
                }
                return Position(x: x, y: y)
            }.first
        }
    }
}

fileprivate extension Character {
    var height: UInt8? {
        switch self {
        case "S":
            return Character("a").asciiValue
        case "E":
            return Character("z").asciiValue
        default:
            return self.asciiValue
        }
    }
}

extension Position {
    var up: Position {
        .init(x: x, y: y - 1)
    }
    
    var down: Position {
        .init(x: x, y: y + 1)
    }
    
    var left: Position {
        .init(x: x - 1, y: y)
    }
    
    var right: Position {
        .init(x: x + 1, y: y)
    }
}
