import XCTest
@testable import AdventOfCode

final class Day13Tests: XCTestCase, SolutionTest {
    typealias SUT = Day13
    
    func testPartOne() throws {
        try XCTAssertEqual(sut.calculatePartOne(), 13)
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(sut.calculatePartTwo(), 0)
    }
}

extension Day13Tests {
    func testInitialisation() throws {
        try XCTAssertEqual(sut.packets.count, 8)        
        try XCTAssertEqual(sut.packets, [
            .init(left: [1, 1, 3, 1, 1],
                  right: [1, 1, 5, 1, 1]),
            .init(left: [[1], [2, 3, 4]],
                  right: [[1],4]),
            .init(left: [9],
                  right: [[8,7,6]]),
            .init(left: [[4,4],4,4],
                  right: [[4,4],4,4,4]),
            .init(left: [7,7,7,7],
                  right: [7,7,7]),
            .init(left: [], right: [3]),
            .init(left: [[[]]], right: [[]]),
            .init(left: [1,[2,[3,[4,[5,6,7]]]],8,9],
                  right: [1,[2,[3,[4,[5,6,0]]]],8,9])
        ])
    }
    
    func testIsOrderedCorrectly() throws {
        try XCTAssertTrue(sut.packets[0].isOrderedCorrectly)
        try XCTAssertTrue(sut.packets[1].isOrderedCorrectly)
        try XCTAssertFalse(sut.packets[2].isOrderedCorrectly)
        try XCTAssertTrue(sut.packets[3].isOrderedCorrectly)
        try XCTAssertFalse(sut.packets[4].isOrderedCorrectly)
        try XCTAssertTrue(sut.packets[5].isOrderedCorrectly)
        try XCTAssertFalse(sut.packets[6].isOrderedCorrectly)
        try XCTAssertFalse(sut.packets[7].isOrderedCorrectly)
    }
    
    func testComparePackets() {
        XCTAssertFalse(Packet.branch([1]) < [1])
        XCTAssertTrue(Packet.branch([2, 3, 4]) < 4)
        XCTAssertTrue(Packet.branch([[1],[2,3,4]]) < [[1], 4])
    }
    
    func testRootDecodableConformance() throws {
        let data = try XCTUnwrap("4".data(using: .utf8))
        let decoder = JSONDecoder()
        let packet = try decoder.decode(Packet.self, from: data)
        XCTAssertEqual(packet, .root(4))
    }
    
    func testBranchDecodableConformance() throws {
        let data = try XCTUnwrap("[1,1,3,1,1]"
            .data(using: .utf8))
        let decoder = JSONDecoder()
        let packet = try decoder.decode(Packet.self, from: data)
        XCTAssertEqual(packet, [1,1,3,1,1])
    }
    
    func testEmptyDecodableConformance() throws {
        let data = try XCTUnwrap("[[[]]]"
            .data(using: .utf8))
        let decoder = JSONDecoder()
        let packet = try decoder.decode(Packet.self, from: data)
        XCTAssertEqual(packet, [[[]]])
    }
    
    func testComplexDecodableConformance() throws {
        let data = try XCTUnwrap("[1,[2,[3,[4,[5,6,7]]]],8,9]"
            .data(using: .utf8))
        let decoder = JSONDecoder()
        let packet = try decoder.decode(Packet.self, from: data)
        XCTAssertEqual(packet, [1,[2,[3,[4,[5,6,7]]]],8,9])
    }
}
