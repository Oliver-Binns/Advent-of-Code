import Foundation

try print("""
Day 8:
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
}

func mapToLines(input: String) -> [Entry] {
    input.components(separatedBy: "\n")
        .compactMap(Entry.init)
}

struct Entry {
    let signals: [Set<Segment>]
    let output: [Set<Segment>]
    
    init?(entry: String) {
        let sections = entry.components(separatedBy: "|")
        guard sections.count == 2,
              let rawSignals = sections.first,
              let rawOutput = sections.last else {
            return nil
        }
        signals = rawSignals.components(separatedBy: " ")
            .map { $0.compactMap(Segment.init) }
            .map(Set.init)
            .filter { !$0.isEmpty }
            .sorted(by: { $0.count < $1.count })
        
        output = rawOutput.components(separatedBy: " ")
            .map { $0.compactMap(Segment.init) }
            .map(Set.init)
            .filter { !$0.isEmpty }
    }
    
    func count1478() -> Int {
        let segmentCounts = output
            .map { $0.count }
            .filter { $0 <= 4 || $0 == 7 }
            .map { ($0, 1) }
        return Dictionary(segmentCounts, uniquingKeysWith: +)
            .values
            .reduce(0, +)
    }
    
    func find(length: Int) -> Set<Segment>? {
        for signal in signals {
            if signal.count < length {
                continue
            } else if signal.count == length {
                return signal
            } else {
                return nil
            }
        }
        return nil
    }
    
    func calculateMapping() -> (Set<Segment>) -> Int {
        let one = find(length: 2)!
        let seven = find(length: 3)!
        let four = find(length: 4)!
        let eight = find(length: 7)!
        
        //let a = seven.subtracting(one)
        let cPlusF = seven.intersection(one)
        let cOrF = cPlusF.first!
        let otherCOrF = cPlusF.filter { $0 != cOrF }.first!
        
        let cOrFCount = signals
            .filter { $0.contains(cOrF) }
            .count
        let c = cOrFCount == 8 ? cOrF : otherCOrF
        let f = cOrFCount == 9 ? cOrF : otherCOrF
        
        let two = signals.filter { !$0.contains(f) }.first!
        
        let noC = signals.filter { !$0.contains(c) }
        let five = noC.filter { $0.count == 5 }.first!
        let six = noC.filter { $0.count == 6 }.first!
        
        let e = six.subtracting(five).first!
        let three = signals
            .filter { !$0.contains(e) }
            .filter { $0.count == 5 }
            .filter { $0 != five }
            .first!
        
        let nine = signals
            .filter { !$0.contains(e) }
            .filter { $0.count == 6 }
            .first!
        
        return {
            switch $0 {
            case one:
                return 1
            case two:
                return 2
            case three:
                return 3
            case four:
                return 4
            case five:
                return 5
            case six:
                return 6
            case seven:
                return 7
            case eight:
                return 8
            case nine:
                return 9
            default:
                return 0
            }
        }
    }
}

enum Segment: Character {
    case a = "a"
    case b = "b"
    case c = "c"
    case d = "d"
    case e = "e"
    case f = "f"
    case g = "g"
}

// MARK: - Solve Challenge 1

func solve(filename: String) throws -> Int {
    let input = try openFile(filename: filename)
    let entries = mapToLines(input: input)
    return entries.map { $0.count1478() }.reduce(0, +)
}

// MARK: - Solve Challenge 2

func solveExtension(filename: String) throws -> Int {
    let input = try openFile(filename: filename)
    let entries = mapToLines(input: input)
    
    return zip(entries.map { $0.calculateMapping() }, entries.map { $0.output })
        .compactMap {
            //print($1.map { $0.map { String($0.rawValue) }.joined() })
            let value = $1.map($0).compactMap(String.init).joined()
            //print(value)
            return Int(value)
        }
        .reduce(0, +)
}
