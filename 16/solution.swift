import Foundation

try print("""
Day 16:
Sample Answer: \(solve(filename: "sample.input"))
Solution Answer: \(solve(filename: "solution.input"))

Extension Task:
Sample Answer: \(solveExtension(filename: "sample.input"))
Solution Answer: \(solveExtension(filename: "solution.input"))
""")

// MARK: - Parse input into data structure

func  openFile(filename: String) throws -> String {
    let cwd = FileManager.default.currentDirectoryPath
    return try String(contentsOfFile: "\(cwd)/\(filename)", encoding: .utf8)
        .trimmingCharacters(in: .whitespacesAndNewlines)
}

func parseInput(_ input: String) -> Packet {
    let mapping: [Character: String] = ["0": "0000",
                                        "1": "0001",
                                        "2": "0010",
                                        "3": "0011",
                                        "4": "0100",
                                        "5": "0101",
                                        "6": "0110",
                                        "7": "0111",
                                        "8": "1000",
                                        "9": "1001",
                                        "A": "1010",
                                        "B": "1011",
                                        "C": "1100",
                                        "D": "1101",
                                        "E": "1110",
                                        "F": "1111"]
    
    var hex = input.compactMap { mapping[$0] }.joined()
    return .init(hex: &hex, addPadding: true)
}

// MARK: - Data Structure

extension String {
    subscript(_ range: Range<Int>) -> String {
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(startIndex, offsetBy: range.upperBound)
        return String(self[start..<end])
    }
    
    @discardableResult
    mutating func first(_ count: Int) -> String {
        String((0..<count).map { _ -> Character in
            removeFirst()
        })
    }
}

enum PacketType {
    case literal(Int)
    case operation([Packet])
}

struct Packet {
    let version: Int
    let id: Int
    let contents: PacketType
    
    init(hex: inout String, addPadding: Bool = false) {
        version = Int(hex.first(3), radix: 2)!
        id = Int(String(hex.first(3)), radix: 2)!
        var length = 6
        
        switch id {
        case 4:
            var groups: [String] = []
            
            while true {
                length += 5
                let group = hex.first(5)
                groups.append(String(group.suffix(4)))
                if group.first == "0" { break }
            }
            contents = .literal(Int(groups.joined(), radix: 2)!)
        default:
            var subpackets: [Packet] = []
            
            if hex.first(1) == "0" {
                length += 15
                let totalLength = Int(hex.first(15), radix: 2)!
                length += totalLength
                
                var subpacketString = hex.first(totalLength)
                while subpacketString.count > 6 {
                    subpackets.append(Packet(hex: &subpacketString))
                }
            } else {
                length += 11
                let subpacketCount = Int(hex.first(11), radix: 2)!
                for _ in 0..<subpacketCount {
                    subpackets.append(Packet(hex: &hex))
                }
            }
            contents = .operation(subpackets)
        }
        
        // drop trailing zeroes:
        if addPadding {
            let trailingZeroes = 4 - (length % 4)
            hex.first(trailingZeroes)
        }
    }
    
    func calculateVersion() -> Int {
        guard case .operation(let packets) = contents else {
            return version
        }
        return packets.map { $0.calculateVersion() } .reduce(version, +)
    }
    
    func performOperation() -> Int {
        switch contents {
        case .literal(let value):
            return value
        case .operation(let subpackets):
            let packets = subpackets.map { $0.performOperation() }
            switch id {
            case 0:
                return packets
                    .reduce(0, +)
            case 1:
                return packets
                    .reduce(1, *)
            case 2:
                return packets
                    .min() ?? 0
            case 3:
                return packets
                    .max() ?? 0
            case 5:
                return packets[0] > packets[1] ? 1 : 0
            case 6:
                return packets[0] < packets[1] ? 1 : 0
            default:
                return packets[0] == packets[1] ? 1 : 0
            }
        }
    }
}

// MARK: - Solve Challenge 1

func solve(filename: String) throws -> Int {
    let input = try openFile(filename: filename)
    return parseInput(input).calculateVersion()
}

func solveExtension(filename: String) throws -> Int {
    let input = try openFile(filename: filename)
    return parseInput(input).performOperation()
}

