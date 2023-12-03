struct Schematic: Equatable {
    let numbers: [Number]
    let symbols: [Coordinate: Character]
    
    init(numbers: [Number],
         symbols: [Coordinate : Character]) {
        self.numbers = numbers
        self.symbols = symbols
    }
    
    init(rawValue: String) {
        self = Self.parse(string: rawValue)
    }
}

extension Schematic {
    static func parseNumber(coordinate: Coordinate,
                            currentNumber: String) -> Number {
        // if new number...
        let endX = coordinate.x + currentNumber.count - 1
        let location = NumberLocation(
            row: coordinate.y,
            columns: coordinate.x...endX
        )
        guard let value = Int(currentNumber) else {
            preconditionFailure("Expected a number, got \(currentNumber)")
        }
        return Number(value: value, location: location)
        
    }
    
    static func parse(string: String) -> Self {
        var symbols: [Coordinate : Character] = [:]
        var numbers: [Number] = []
        
        var numberStart: Coordinate?
        var currentNumber = ""
        
        func updateNumber(start: Coordinate) {
            numbers.append(parseNumber(coordinate: start,
                                       currentNumber: currentNumber))
            
            currentNumber = ""
        }
        
        string
            .components(separatedBy: .newlines)
            .enumerated()
            .forEach { (row, line) in
                for (column, character) in line.enumerated()
                where character != "." {
                    if let start = numberStart,
                       // if row has changed... 
                       // then this must be a new number
                       row != start.y {
                        updateNumber(start: start)
                        numberStart = nil
                    }
                    
                    if character.isNumber {
                        if let start = numberStart,
                            // there is a gap in the number:
                            (start.x + currentNumber.count) < column {
                            updateNumber(start: start)
                            numberStart = Coordinate(x: column, y: row)
                        } else if numberStart == nil {
                            numberStart = Coordinate(x: column, y: row)
                        }

                        currentNumber.append(character)
                    } else {
                        let coordinate = Coordinate(x: column, y: row)
                        symbols[coordinate] = character
                    }
                }
            }
        
        if let numberStart {
            updateNumber(start: numberStart)
        }
        
        return Schematic(numbers: numbers, symbols: symbols)
    }
}
