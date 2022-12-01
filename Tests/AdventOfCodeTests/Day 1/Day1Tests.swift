import XCTest
@testable import AdventOfCode

final class Day1Tests: XCTestCase, SolutionTest {
    typealias SUT = Day1
    
    func testPartOne() throws {
        try XCTAssertEqual(sut.calculatePartOne(), 24000)
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(sut.calculatePartTwo(), 45000)
    }
}

extension Day1Tests {    
    func testSum() throws {
        func testTotals() throws {
            try XCTAssertEqual(sut.caloriesCarried, [
                24000,
                11000,
                10000,
                6000,
                4000
            ])
        }
    }
}
