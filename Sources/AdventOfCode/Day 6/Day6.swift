struct Day6: Solution {
    static let day = 6
    
    let races: [Race]
    let racePart2: Race
    
    init(input: String) {
        let lines = input
            .components(separatedBy: .newlines)
            .map {
                $0
                .components(separatedBy: .whitespaces)
                .compactMap(Int.init)
            }
        races = zip(lines[0], lines[1]).map {
            Race(time: $0, distance: $1)
        }
        
        let two = input
            .components(separatedBy: .newlines)
            .map {
                $0.filter(\.isNumber)
            }
            .compactMap(Int.init)

        racePart2 = Race(time: two[0], distance: two[1])
    }
    
    func calculatePartOne() -> Int {
        races
            .map(possibleValues(for:))
            .reduce(1, *)
    }
    
    func checkBoat(time: Int, for race: Race) -> Bool {
        Boat(holdTime: time)
            .distanceTravelled(in: race.time) > race.distance
    }
    
    func possibleValues(for race: Race) -> Int {
        let range = 1..<race.time
        
        guard let first = range
            .first(where: { checkBoat(time: $0, for: race) }),
              let last = range
            .last(where: { checkBoat(time: $0, for: race) }) else {
            preconditionFailure("Found no matching successful races")
        }
        
        return last - first + 1
    }
    
    func calculatePartTwo() -> Int {
        possibleValues(for: racePart2)
    }
}
