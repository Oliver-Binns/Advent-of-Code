import XCTest
@testable import AdventOfCode

final class Day15Tests: XCTestCase, SolutionTest {
    let day = 15
    
    func testPartOne() throws {
        try XCTAssertEqual(Day15(input: getTestData()).calculatePartOne(), 0)
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(Day15(input: getTestData()).calculatePartTwo(), 0)
    }
}

extension Day15Tests {
    func testInitialisation() throws {
        let sut = try Day15(input: getTestData())
        XCTAssertEqual(sut.numbers, [0, 3, 6])
    }
}
