import Algorithms

struct Day25: Solution {
    static let day = 25

    let schematics: [Schematic]

    var locks: [Schematic] {
        schematics.filter { $0.type == .lock }
    }

    var keys: [Schematic] {
        schematics.filter { $0.type == .key }
    }

    init(input: String) {
        schematics = input
            .trimmingCharacters(in: .newlines)
            .components(separatedBy: "\n\n")
            .map(Schematic.init)
    }
    
    func calculatePartOne() -> Int {
        keys.map { key in
            locks.filter { lock in
                zip(lock.pinHeights, key.pinHeights)
                    .map(+)
                    .allSatisfy { $0 <= 5 }
            }.count
        }.reduce(0, +)
    }
    
    func calculatePartTwo() -> Int {
        0
    }
}

struct Schematic {
    let type: SchematicType
    let entries: Grid<SchematicEntry>
}

extension Schematic {
    init(string: String) {
        guard let endOfFirstLine = string.firstIndex(of: "\n"),
              let startOfLastLine = string.lastIndex(of: "\n") else {
            fatalError("Invalid schematic: \(string)")
        }

        type = if string.prefix(upTo: endOfFirstLine) == "#####" {
            .lock
        } else {
            .key
        }

        let substring = string
            .suffix(from: endOfFirstLine)
            .prefix(upTo: startOfLastLine)

        entries = Grid(
            string: substring,
            mapping: SchematicEntry.init
        )
    }

    var pinHeights: [Int] {
        (0..<entries.values[0].count).map { column in
            entries.values
                .map { $0[column] }
                .count(where: { $0 == .filled })
        }
    }
}

enum SchematicType {
    case key
    case lock
}

enum SchematicEntry: Character {
    case filled = "#"
    case empty = "."
}
