import XCTest
@testable import AdventOfCode

final class Day11Tests: XCTestCase, SolutionTest {
    typealias SUT = Day11
    
    func testPartOne() throws {
        try XCTAssertEqual(sut.calculatePartOne(), 10605)
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(sut.calculatePartTwo(), 0)
    }
}

extension Day11Tests {
    func testInitialisation() throws {
        try XCTAssertEqual(sut.monkeys.count, 4)
    }
}
