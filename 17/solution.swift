import Foundation

try print("""
Day 17:
Sample Answer: \(solve(filename: "sample.input"))
Solution Answer: \(solve(filename: "solution.input"))

Extension Task:
Sample Answer: \(solveExtension(filename: "sample.input"))
Solution Answer: \(solveExtension(filename: "solution.input"))
""")

// MARK: - Parse input into data structure

func openFile(filename: String) throws -> String {
    let cwd = FileManager.default.currentDirectoryPath
    return try String(contentsOfFile: "\(cwd)/\(filename)", encoding: .utf8)
        .trimmingCharacters(in: .whitespacesAndNewlines)
}

func getTargetArea(input: String) -> TargetArea {
    let index = input.index(input.startIndex, offsetBy: "target area: ".count)
    let rangeStrings: [String] = String(input.suffix(from: index)).components(separatedBy: ", ")
        .map { // Remove x=, y=
            let index = $0.index($0.startIndex, offsetBy: 2)
            return String($0.suffix(from: index))
        }
    let ranges = rangeStrings.map { // convert to range
        $0.components(separatedBy: "..").compactMap(Int.init)
    }.map {
        $0[0]...$0[1]
    }

    return .init(horizontalRange: ranges[0], verticalRange: ranges[1])
}

// MARK: - Data Structure

struct TargetArea {
    let horizontalRange: ClosedRange<Int>
    let verticalRange: ClosedRange<Int>
}

struct Coordinate: Equatable {
    let x: Int
    let y: Int
}
extension Coordinate {
    static func +(lhs: Self, rhs: Self) -> Self {
        Coordinate(x: lhs.x + rhs.x,
                   y: lhs.y + rhs.y)
    }
}

struct Probe {
    let position: Coordinate
    let velocity: Coordinate

    func next() -> Probe {
        let xAcceleration: Int
        switch velocity.x {
        case Int.min..<0:
            xAcceleration = 1
        case 0:
            xAcceleration = 0
        default:
            xAcceleration = -1
        }

        return .init(position: position + velocity,
              velocity: velocity + Coordinate(x: xAcceleration, y: -1))
    }

    func isInTargetArea(_ targetArea: TargetArea) -> Bool {
        targetArea.horizontalRange.contains(position.x) &&
            targetArea.verticalRange.contains(position.y)
    }
}

func printGrid(probePositions: [Coordinate], targetArea: TargetArea) {
    for row in (targetArea.verticalRange.lowerBound...10).reversed() {
        print((0...targetArea.horizontalRange.upperBound).map { x in
            (probePositions.contains(.init(x: x, y: row))) ? "#" :
                (targetArea.verticalRange.contains(row) &&
                    targetArea.horizontalRange.contains(x) ? "T" : ".")
        }.joined())
    }
}

// MARK: - Challenge 1 Solution

func solve(filename: String) throws -> Int {
    let input = try openFile(filename: filename)
    let targetArea = getTargetArea(input: input)

    let xs = 0...targetArea.horizontalRange.upperBound
    let ys = 0...300

    return xs
        .flatMap { x in
            ys.map { (x, $0) }
        }
        .map { (x, y) in
            Probe(position: .init(x: 0, y: 0), velocity: .init(x: x, y: y))
        }.compactMap {
            getMaxHeightForProbe($0, aimingFor: targetArea)
        }
        .max() ?? 0
}

func getMaxHeightForProbe(_ probe: Probe, aimingFor targetArea: TargetArea) -> Int? {
    var positions = [probe]
    while let probe = positions.last,
          probe.position.x <= targetArea.horizontalRange.upperBound,
          probe.position.y >= targetArea.verticalRange.lowerBound {
        if probe.isInTargetArea(targetArea) {
            return positions.map { $0.position.y }.max()
        }
        positions.append(probe.next())
    }
    return nil
}

// MARK: - Challenge 2 Solution

func solveExtension(filename: String) throws -> Int {
    let input = try openFile(filename: filename)
    let targetArea = getTargetArea(input: input)

    let xs = 0...targetArea.horizontalRange.upperBound
    let ys = -300...300

    return xs
        .flatMap { x in
            ys.map { (x, $0) }
        }
        .map { (x, y) in
            Probe(position: .init(x: 0, y: 0), velocity: .init(x: x, y: y))
        }
        .filter { probe($0, reachesTargetArea: targetArea) }
        .count
}

func probe(_ probe: Probe, reachesTargetArea targetArea: TargetArea) -> Bool {
    var positions = [probe]
    while let probe = positions.last,
          probe.position.x <= targetArea.horizontalRange.upperBound,
          probe.position.y >= targetArea.verticalRange.lowerBound {
        if probe.isInTargetArea(targetArea) {
            return true
        }
        positions.append(probe.next())
    }
    return false
}
