import XCTest
@testable import AdventOfCode

final class Day5Tests: XCTestCase, SolutionTest {
    typealias SUT = Day5
    
    func testPartOne() throws {
        try XCTAssertEqual(sut.calculatePartOne(), 143)
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(sut.calculatePartTwo(), 123)
    }
}

extension Day5Tests {
    func testParsing() throws {
        XCTAssertEqual(
            try sut.updates,
            [
                [75,47,61,53,29],
                [97,61,53,29,13],
                [75,29,13],
                [75,97,47,61,53],
                [61,13,29],
                [97,13,75,29,47]
            ]
        )
    }

    func testIsValid() throws {
        XCTAssertTrue(try sut.isValid(update: [75,47,61,53,29]))
        XCTAssertTrue(try sut.isValid(update: [97,61,53,29,13]))
        XCTAssertTrue(try sut.isValid(update: [75,29,13]))

        XCTAssertFalse(try sut.isValid(update: [75,97,47,61,53]))
        XCTAssertFalse(try sut.isValid(update: [61,13,29]))
        XCTAssertFalse(try sut.isValid(update: [97,13,75,29,47]))
    }

    func testMiddlePage() throws {
        XCTAssertEqual(
            try sut.middlePage(of: [75,47,61,53,29]),
            61
        )
        XCTAssertEqual(
            try sut.middlePage(of: [97,61,53,29,13]),
            53
        )
        XCTAssertEqual(
            try sut.middlePage(of: [75,29,13]),
            29
        )
    }
}
