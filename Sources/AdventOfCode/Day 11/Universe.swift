struct Universe {
    let galaxyLocations: Set<Coordinate>
    
    var width: Int {
        galaxyLocations.map(\.x).max() ?? 0
    }
    
    var height: Int {
        galaxyLocations.map(\.y).max() ?? 0
    }
    
    private init(map: [[Space]]) {
        galaxyLocations = map
            .enumerated()
            .reduce(into: []) { set, row in
                row.element
                    .enumerated()
                    .filter { $0.element == .galaxy }
                    .map(\.offset)
                    .forEach {
                        set.insert(Coordinate(x: $0, y: row.offset))
                    }
            }
    }
    
    private init(galaxyLocations: Set<Coordinate>) {
        self.galaxyLocations = galaxyLocations
    }
    
    init(rawValue: String) {
        let map = rawValue
            .components(separatedBy: .newlines)
            .filter(\.isNotEmpty)
            .map {
                $0.compactMap(Space.init)
            }
        self.init(map: map)
    }
    
    func expanded(age: Int = 1) -> Universe {
        let emptyRows = (0...height).filter { rowIndex in
            !galaxyLocations.contains(where: { $0.y == rowIndex })
        }
        let emptyColumns = (0...width).filter { columnIndex in
            !galaxyLocations.contains(where: { $0.x == columnIndex })
        }
        
        let newLocations = Set(galaxyLocations.map { location in
            let xOffset = emptyColumns
                .filter { $0 < location.x }
                .count * age
            
            let yOffset = emptyRows
                .filter { $0 < location.y }
                .count * age
            
            return Coordinate(x: location.x + xOffset,
                              y: location.y + yOffset)
        })
        
        return Universe(galaxyLocations: newLocations)
    }
}

extension Universe: CustomStringConvertible {
    var description: String {
        (0...height).map { row in
            (0...width).map { column in
                guard galaxyLocations.contains(.init(x: column, y: row)) else {
                    return Space.empty
                }
                return Space.galaxy
            }
            .map {
                String($0.rawValue)
            }
            .joined()
        }
        .joined(separator: "\n")
    }
}

enum Space: Character {
    case empty = "."
    case galaxy = "#"
}
