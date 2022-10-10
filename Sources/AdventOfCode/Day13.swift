final class Day13: Solution {
    let day = 13
    
    let earliestDeparture: Int
    let buses: [Int?]
    
    
    init(input: String) {
        let lines = input.split(whereSeparator: { $0.isWhitespace })
        earliestDeparture = Int(lines[0])!
        
        buses = lines[1]
            .split(separator: ",")
            .map(String.init)
            .map(Int.init)
    }
    
    func calculatePartOne() -> Int {
        let timetable = buses
            .compactMap { $0 }
            .map { (busID: $0, nextDeparture: nextDeparture(ofBus: $0, after: earliestDeparture)) }
        
        guard let nextBus = timetable.min(by: { $0.nextDeparture < $1.nextDeparture }) else { return 0 }
        
        return nextBus.busID * (nextBus.nextDeparture - earliestDeparture)
        
    }
    
    func calculatePartTwo() -> Int {
        0
    }
}

extension Day13 {
    func nextDeparture(ofBus busID: Int, after time: Int) -> Int {
        // Integer division should take care of this for us!
        let previousTime = (time / busID) * busID
        return previousTime + busID
    }
}
