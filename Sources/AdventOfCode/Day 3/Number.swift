struct Number: Hashable, Equatable {
    let value: Int
    let location: NumberLocation
}

struct NumberLocation: Hashable,Equatable {
    let row: Int
    let columns: ClosedRange<Int>
    let coordinates: Set<Coordinate>
    
    init(row: Int, columns: ClosedRange<Int>) {
        self.row = row
        self.columns = columns
        self.coordinates = Set(columns.map {
            Coordinate(x: $0, y: row)
        })
    }
}

extension NumberLocation {    
    var surroundingCoordinates: Set<Coordinate> {
        Set(
            columns.flatMap { column in
                [
                    Coordinate(x: column, y: row - 1),
                    Coordinate(x: column, y: row + 1)
                ]
            } + (-1...1).flatMap {
                [
                    Coordinate(x: columns.lowerBound - 1, y: row + $0),
                    Coordinate(x: columns.upperBound + 1, y: row + $0)
                ]
            }
        )
    }
}
