import Foundation

struct Day5 {
    let day = 5
    
    private let lines: [String]
    var seats: [Seat] {
        lines.map { rawPosition -> Seat in
            Seat(row: rawPosition
                    .prefix(rowPartitions)
                    .compactMap { character -> Search? in
                        switch character {
                        case "F": return .lower
                        case "B": return .upper
                        default: return nil
                        }
                    }.reduce(0...rows-1) { range, half in
                        halfRange(range, toHalf: half)
                    }.lowerBound,
                column: rawPosition.suffix(columnPartitions)
                    .compactMap { character -> Search? in
                        switch character {
                        case "L": return .lower
                        case "R": return .upper
                        default: return nil
                        }
                    }.reduce(0...columns-1) { range, half in
                        halfRange(range, toHalf: half)
                    }.lowerBound
            )
        }
    }
    
    let rows = 128
    var rowPartitions: Int { Int(log2(Float(rows))) }

    let columns = 8
    var columnPartitions: Int { Int(log2(Float(columns))) }
    
    init(input: String) {
        self.lines = input
            .split(whereSeparator: { $0.isNewline })
            .map(String.init)
    }
    
    func halfRange(_ range: ClosedRange<Int>, toHalf half: Search) -> ClosedRange<Int> {
        let difference = Double(range.count - 1)
        let median = Double(range.lowerBound) + difference / 2

        switch half {
        case .lower:
            return range.lowerBound...Int(floor(median))
        case .upper:
            return Int(ceil(median))...range.upperBound
        }
    }
    
    func findSeat() -> Seat? {
        for row in 0..<rows {
            for column in 0..<columns {
                let seat = Seat(row: row, column: column)
                if !seats.contains(.init(row: row, column: column)),
                   seats.contains(where: { $0.id == seat.id - 1 }),
                   seats.contains(where: { $0.id == seat.id + 1 }) {
                    return Seat(row: row, column: column)
                }
            }
        }
        return nil
    }
}

extension Day5: Solution {
    func calculatePartOne() -> String {
        guard let max = seats.map({ $0.id }).max() else {
            preconditionFailure("Could not find any seats.")
        }
        return max.description
    }
    
    func calculatePartTwo() -> String {
        guard let seat = findSeat() else {
            preconditionFailure("Could not find empty seat")
        }
        return seat.id.description
    }
}




enum Search {
    case lower
    case upper
}
struct Seat {
    var id: Int {
        row * 8 + column
    }

    let row: Int
    let column: Int
}

extension Seat: Equatable { }
