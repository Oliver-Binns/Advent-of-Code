import XCTest
@testable import AdventOfCode

final class Day14Tests: XCTestCase, SolutionTest {
    typealias SUT = Day14
    
    func testPartOne() throws {
        try XCTAssertEqual(sut.calculatePartOne(), 0)
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(sut.calculatePartTwo(), 0)
    }
}

extension Day14Tests {
    func testInitialisation() {
        try XCTAssertEqual(sut.path, [
            [Position(x: 498, y: 4), .init(x: 498, y: 6), .init(x: 496, y: 6)],
            [Position(x: 503, y: 4), .init(x: 502, y: 4), .init(x: 502, y: 9), .init(x: 494, y: 9)]
        ])
    }
}
