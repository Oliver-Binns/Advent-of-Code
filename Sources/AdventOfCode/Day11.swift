final class Day11: Solution {
    let day = 11
    
    private(set) var state: Plane
    
    init(input: String) {
        state = input
            .split(whereSeparator: { $0.isWhitespace })
            .map { $0.compactMap(Position.init) }
    }
    
    func calculatePartOne() -> Int {
        while true {
            let previous = state
            
            board()
            
            if previous == state {
                break
            }
        }
        
        return state
            .map { $0.filter { $0 == .occupied }.count }
            .reduce(0, +)
    }
    
    func calculatePartTwo() -> Int {
        while true {
            let previous = state
            
            board(tolerance: 5, directlyAdjacent: false)
            
            if previous == state {
                break
            }
        }
        
        return state
            .map { $0.filter { $0 == .occupied }.count }
            .reduce(0, +)
    }
}

extension Day11 {
    enum Position: Character {
        case occupied = "#"
        case empty = "L"
        case floor = "."
    }
    
    typealias Plane = [[Position]]
    
    func position(atX x: Int, y: Int) -> Position? {
        guard x >= 0,
              y >= 0,
              y < state.count,
              x < state[0].count else { return nil }
        return state[y][x]
    }
    
    func adjacentSeats(atX x: Int, y: Int) -> [Position] {
        [
            position(atX: x-1, y: y-1),
            position(atX: x-1, y: y),
            position(atX: x-1, y: y+1),
        
            position(atX: x, y: y-1),
            position(atX: x, y: y+1),
        
            position(atX: x+1, y: y-1),
            position(atX: x+1, y: y),
            position(atX: x+1, y: y+1),
        ].compactMap { $0 }
    }
    
    func findNextSeat(atX x: Int, xOffset: Int,
                      y: Int, yOffset: Int) -> Position? {
        guard let position = position(atX: x + xOffset,
                                      y: y + yOffset) else {
            return nil
        }
        
        switch position {
        case .floor:
            return findNextSeat(atX: x + xOffset, xOffset: xOffset,
                                y: y + yOffset, yOffset: yOffset)
        default:
            return position
        }
    }
    
    func visibleSeats(atX x: Int, y: Int) -> [Position] {
        [
            (-1, -1),
            (-1,  0),
            (-1, +1),
            ( 0, -1),
            ( 0, +1),
            (+1, -1),
            (+1,  0),
            (+1, +1),
        ].compactMap {
            findNextSeat(atX: x, xOffset: $0.0, y: y, yOffset: $0.1)
        }
    }
    
    func occupiedVisibleSeats(atX x: Int, y: Int) -> Int {
        visibleSeats(atX: x, y: y)
            .filter { $0 == .occupied }
            .count
    }
    
    func occupiedAdjacentSeats(atX x: Int, y: Int) -> Int {
        adjacentSeats(atX: x, y: y)
            .filter { $0 == .occupied }
            .count
    }
    
    func board(tolerance: Int = 4, directlyAdjacent: Bool = true) {
        var temp = state
        
        for y in 0..<state.count {
            for x in 0..<state[0].count {
                let occupiedCount = directlyAdjacent ?
                    occupiedAdjacentSeats(atX: x, y: y) :
                    occupiedVisibleSeats(atX: x, y: y)
                
                switch state[y][x] {
                case .empty where occupiedCount == 0:
                    temp[y][x] = .occupied
                case .occupied where occupiedCount >= tolerance:
                    temp[y][x] = .empty
                default: break
                }
            }
        }
        
        state = temp
    }
}

extension Array where Element == [Day11.Position] {
    var string: String {
        String(map {
            String($0.map { $0.rawValue })
        }.joined(separator: "\n"))
    }
}
