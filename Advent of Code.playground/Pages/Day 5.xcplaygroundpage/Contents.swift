//: [Previous](@previous)
import Cocoa

guard let fileURL = Bundle.main
        .url(forResource: "Seat Map", withExtension: nil),
      let fileContents = try? String(contentsOf: fileURL) else {
    preconditionFailure("Could not decode input data")
}

let boardingPasses = fileContents.split(whereSeparator: { $0.isNewline })

let rows = 128
let rowPartitions = Int(log2(Float(rows)))

let columns = 8
let columnPartitions = Int(log2(Float(columns)))

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

let seats = boardingPasses.map { rawPosition -> Seat in
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


guard let max = seats.map({ $0.id }).max() else {
    preconditionFailure("Could not find any seats.")
}
print("Challenge 1 Solution: \(max)")

extension Seat: Equatable { }

let findSeat = { () -> Seat? in
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

guard let seat = findSeat() else {
    preconditionFailure("Could not find empty seat")
}
print("Challenge 2 Solution: \(seat.id)")
//: [Next](@next)
