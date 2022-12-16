import Foundation

struct Day13: Solution {
    static let day = 13
    
    let packets: [PacketPair]
    
    init(input: String) {
        packets = input
            .components(separatedBy: "\n\n")
            .map {
                $0
                .components(separatedBy: .newlines)
                .filter(!\.isEmpty)
            }
            .compactMap { pair -> PacketPair? in
                guard let leftData = pair.first?.data(using: .utf8),
                      let rightData = pair.last?.data(using: .utf8) else {
                    return nil
                }
                
                let jsonDecoder = JSONDecoder()
                return try? PacketPair(left: jsonDecoder
                    .decode(Packet.self, from: leftData),
                                       right: jsonDecoder
                    .decode(Packet.self, from: rightData))
            }
    }
    
    func calculatePartOne() -> Int {
        packets
            .enumerated()
            .filter(\.element.isOrderedCorrectly)
            .map(\.offset)
            .map { $0 + 1 }
            .reduce(0, +)
    }
    
    func calculatePartTwo() -> Int {
        0
    }
}

struct PacketPair: Equatable {
    let left: Packet
    let right: Packet
    
    var isOrderedCorrectly: Bool {
        left < right
    }
}

enum Packet: Equatable {
    case branch([Packet])
    case root(Int)
}

extension Packet: Comparable {
    static func < (lhs: Packet, rhs: Packet) -> Bool {
        switch (lhs, rhs) {
        case (.root(let lhsValue), .root(let rhsValue)):
            return lhsValue < rhsValue
        case (.branch(let lhsValue), .branch(let rhsValue)):
            guard let comparison = zip(lhsValue, rhsValue)
                .filter({ $0 != $1 })
                .map({ $0 < $1 })
                .first else {
                    return lhsValue.count < rhsValue.count
                }
            return comparison
        case (.root(let lhsValue), let rhsValue):
            return Packet.branch([.root(lhsValue)]) < rhsValue
        case (let lhsValue, .root(let rhsValue)):
            return lhsValue < Packet.branch([.root(rhsValue)])
        }
    }
}

extension Packet: ExpressibleByIntegerLiteral {
    init(integerLiteral value: IntegerLiteralType) {
        self = .root(value)
    }
}

extension Packet: ExpressibleByArrayLiteral {
    typealias ArrayLiteralElement = Packet
    
    init(arrayLiteral elements: ArrayLiteralElement...) {
        self = .branch(elements)
    }
}

extension Packet: Decodable {
    init(from decoder: Decoder) throws {
        do {
            let value = try decoder
                .singleValueContainer()
                .decode(Int.self)
            self = .root(value)
        } catch {
            let value = try decoder
                .singleValueContainer()
                .decode([Packet].self)
            self = .branch(value)
        }
    }
}
