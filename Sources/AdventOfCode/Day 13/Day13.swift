struct Day13: Solution {
    static let day = 13

    let machines: [ClawMachine]

    init(input: String) {
        machines = input
            .components(separatedBy: "\n\n")
            .filter { !$0.isEmpty }
            .compactMap(ClawMachine.init)
    }
    
    func calculatePartOne() -> Int {
        machines
            .map(winOptions)
            .map { $0.map(+) }
            .map { $0.min() ?? 0 }
            .reduce(0, +)

    }

    func winOptions(for machine: ClawMachine) -> [(x: Int, y: Int)] {
        var options: [(x: Int, y: Int)] = []

        for a in (0..<100) {
            for b in (0..<100) {

                let x = a * machine.buttonA.x + b * machine.buttonB.x
                let y = a * machine.buttonA.y + b * machine.buttonB.y

                if x == machine.prize.x && y == machine.prize.y {
                    options.append((x: a * 3, y: b))
                } else if x > machine.prize.x || y > machine.prize.y {
                    break
                }
            }
        }

        return options
    }

    func calculatePartTwo() -> Int {
        0
    }
}

struct ClawMachine: Equatable {
    let buttonA: Point
    let buttonB: Point

    let prize: Point
}

extension ClawMachine {
    init?(string: String) {
        let components = string.components(separatedBy: .newlines)

        guard let buttonA = Self.parse(line: components[0]),
              let buttonB = Self.parse(line: components[1]),
              let prize = Self.parse(line: components[2]) else {
            return nil
        }

        self.buttonA = buttonA
        self.buttonB = buttonB
        self.prize = prize
    }

    static func parse(line: String) -> Point? {
        let search = /[A-Za-z ]+: X[\+=](?<x>\d+), Y[\+=](?<y>\d+)/
        guard let result = try? search.wholeMatch(in: line),
              let x = Int(result.x),
              let y = Int(result.y) else {
            print("no match")
            return nil
        }

        return Point(x: x, y: y)
    }
}


