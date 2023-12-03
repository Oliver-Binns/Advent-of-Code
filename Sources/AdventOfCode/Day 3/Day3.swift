struct Day3: Solution {
    static let day = 3
    
    let schematic: Schematic
    
    init(input: String) {
        schematic = Schematic(rawValue: input)
    }
    
    func calculatePartOne() -> Int {
        let symbolLocations = Set(schematic.symbols.keys)
        
        return schematic.numbers.reduce(0) { value, number in
            if number.location.surroundingCoordinates
                .contains(where: {
                    symbolLocations.contains($0)
                }) {
                return value + number.value
            }
            return value
        }
    }
    
    func numbersAroundLocation(coordinate: Coordinate,
                               using: [Coordinate : Number]) -> Set<Number> {
        Set(coordinate.surroundingCoordinates.flatMap { coordinate in
            schematic.numbers.filter {
                $0.location.coordinates.contains(coordinate)
            }
        })
    }
    
    func calculatePartTwo() -> Int {
        let numbers: [Coordinate: Number] = schematic.numbers
            .reduce(into: [:]) { dictionary, number in
                number.location.coordinates.forEach {
                    dictionary[$0] = number
                }
            }
        
        return schematic.symbols
            .filter { $0.value == "*" }
            .map(\.key)
            .map {
                numbersAroundLocation(coordinate: $0, using: numbers)
            }
            .filter { $0.count >= 2 }
            .map { 
                $0
                    .map(\.value)
                    .reduce(1, *)
            }
            .reduce(0, +)
    }
}
