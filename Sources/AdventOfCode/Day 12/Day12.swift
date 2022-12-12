struct Day12: Solution {
    static let day = 12
    
    let initialState: State
    
    init(input: String) {
        let map = input
            .components(separatedBy: .newlines)
            .map(Array.init)
            .filter(!\.isEmpty)
        
        guard let startPosition = map.findPosition(of: "S"),
              let endPosition = map.findPosition(of: "E") else {
            preconditionFailure("Could not find start or end position")
        }
        
        initialState = .init(map: .init(map),
                             visited: [startPosition],
                             routes: [0: [startPosition]], goal: endPosition)
    }
    
    func calculatePartOne() -> Int {
        var state = initialState
        
        while state.bestRoute == nil {
            state = state.iterate()
        }
        
        return state.bestRoute!
    }
    
    func calculatePartTwo() -> Int {
        0
    }
}

extension Day12 {
    struct State: Equatable {
        let map: Map
        let visited: Set<Position>
        let goal: Position
        let routes: [Int: Set<Position>]
        
        var bestRoute: Int? {
            routes
                .filter { $0.value.contains(goal) }
                .keys
                .min()
        }
        
        init(map: Map = .init(),
             visited: Set<Position> = [],
             routes: [Int: Set<Position>] = [:],
             goal: Position) {
            self.map = map
            self.visited = visited
            self.goal = goal
            self.routes = routes
        }
        
        func iterate() -> State {
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
            .filter { map.canMove(from: bestPosition, to: $0) }
            
            newPositions.forEach {
                routes[lowestValue + 1, default: []].insert($0)
            }
            
            if routes[lowestValue]!.isEmpty {
                routes.removeValue(forKey: lowestValue)
            }
            
            return .init(map: map,
                         visited: visited.union(newPositions),
                         routes: routes,
                         goal: goal)
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
                     to destination: Position) -> Bool {
            guard isPositionInBounds(destination) else { return false }
            let originValue = map[origin.y][origin.x]
            let destinationValue = map[destination.y][destination.x]
            
            switch (originValue, destinationValue) {
            case ("S", "a"): return true
            case (_, "S"): preconditionFailure("cannot go back to start")
            case ("S", _): return false
            case ("z", "E"): return true
            case (_, "E"): return false
            default:
                guard let originAscii = originValue.asciiValue,
                      let destinationAscii = destinationValue.asciiValue else {
                    preconditionFailure("Expected cell to be ascii value")
                }
                return Int(originAscii) - Int(destinationAscii) >= -1
            }
        }
    }
}

fileprivate extension Array where Element == [Character] {
    func findPosition(of character: Character) -> Position? {
        enumerated().compactMap { (y, row) in
            guard let x = row.firstIndex(of: character) else {
                return nil
            }
            return Position(x: x, y: y)
        }.first
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
