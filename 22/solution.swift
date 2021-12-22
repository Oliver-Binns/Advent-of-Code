import Foundation

try print("""
Day 22:
Sample Answer: \(solve(filename: "sample.input"))
Solution Answer: \(solve(filename: "solution.input"))

Extension Task:
Sample Answer: \(solveExtension(filename: "sample2.input"))
Solution Answer: \(solveExtension(filename: "solution.input"))
""")

// MARK: - Parse input into data structure

func openFile(filename: String) throws -> String {
    let cwd = FileManager.default.currentDirectoryPath
    return try String(contentsOfFile: "\(cwd)/\(filename)", encoding: .utf8)
        .trimmingCharacters(in: .whitespacesAndNewlines)
}

func parseInput(_ input: String) -> [State] {
    input
        .components(separatedBy: "\n")
        .map(parseLine)
}

func parseLine(_ line: String) -> State {
    let parts = line.components(separatedBy: " ")
    return (parts[0] == "on", parseVolume(parts[1]))
}

func parseVolume(_ volume: String) -> Volume {
    let volume = volume
        .components(separatedBy: ",")
        .map(parseRange)
    return .init(x: volume[0], y: volume[1], z: volume[2])
}

func parseRange(_ volume: String) -> ClosedRange<Int> {
    let index = volume.index(volume.startIndex, offsetBy: 2)
    let rangeValues = volume
        .suffix(from: index)
        .components(separatedBy: "..")
        .compactMap(Int.init)
    return rangeValues[0]...rangeValues[1]
}

// MARK: - Data Structure

typealias State = (Bool, Volume)

extension ClosedRange where Bound == Int {
    func splitting(around range: Self) -> Set<Self> {
        Set([
            lowerBound < range.lowerBound ? lowerBound...range.lowerBound-1 : nil,
            range.clamped(to: self),
            range.upperBound < upperBound ? range.upperBound+1...upperBound : nil
        ].compactMap { $0 })
    }

    func isSupersetOf(_ range: Self) -> Bool {
        lowerBound <= range.lowerBound && upperBound >= range.upperBound
    }

    static var full: Self {
        Int.min...Int.max
    }
}

struct Volume: Hashable {
    let x: ClosedRange<Int>
    let y: ClosedRange<Int>
    let z: ClosedRange<Int>

    var count: Int {
        x.count * y.count * z.count
    }

    func overlaps(_ volume: Volume) -> Bool {
        x.overlaps(volume.x) &&
        y.overlaps(volume.y) &&
        z.overlaps(volume.z)
    }

    func isSupersetOf(_ volume: Volume) -> Bool {
        x.isSupersetOf(volume.x) &&
        y.isSupersetOf(volume.y) &&
        z.isSupersetOf(volume.z)
    }

    func difference(_ volume: Volume) -> Set<Volume> {
        return Set(x.splitting(around: volume.x).flatMap { xs in
            y.splitting(around: volume.y).flatMap { ys in
                z.splitting(around: volume.z).compactMap { zs in
                    let new = Volume(x: xs, y: ys, z: zs)
                    guard volume.isSupersetOf(new) else {
                        return new
                    }
                    return nil
                }
            }
        })
    }

    static var outsideInitialisationArea: Set<Volume> {
        Volume(x: .full, y: .full, z: .full)
            .difference(Volume(x: -50...50, y: -50...50, z: -50...50))
    }
}

struct ReactorCore {
    let volumes: Set<Volume>

    var enabledSwitches: Int {
        volumes.map { $0.count }.reduce(0, +)
    }

    init(volumes: Set<Volume> = []) {
        self.volumes = volumes
    }

    func toggleStateOn(_ on: Bool, within volume: Volume) -> Self {
        guard !volumes.isEmpty else {
            return on ? Self(volumes: [volume]) : self
        }

        let overlappingVolumes = volumes.filter { $0.overlaps(volume) }
        let differencedVolumes = overlappingVolumes.flatMap { $0.difference(volume) }

        if on {
            return Self(volumes: volumes
                            .subtracting(overlappingVolumes)
                            .union(differencedVolumes)
                            .union([volume]))
        } else {
            return Self(volumes: volumes
                            .subtracting(overlappingVolumes)
                            .union(differencedVolumes))
        }
    }
}


// MARK: - Challenge 1 Solution

func solve(filename: String,
           additionalChanges: [State] = Volume.outsideInitialisationArea.map { (false, $0) }) throws -> Int {
    let input = try openFile(filename: filename)
    let rebootSequence = parseInput(input) + additionalChanges
    return rebootSequence.reduce(ReactorCore()) { core, step in
        core.toggleStateOn(step.0, within: step.1)
    }.enabledSwitches
}

// MARK: - Challenge 2 Solution
func solveExtension(filename: String) throws -> Int {
    try solve(filename: filename, additionalChanges: [])
}
