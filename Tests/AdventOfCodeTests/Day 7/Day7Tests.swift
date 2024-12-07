import XCTest
@testable import AdventOfCode

final class Day7Tests: XCTestCase, SolutionTest {
    typealias SUT = Day7

    func testPartOne() throws {
        try XCTAssertEqual(sut.calculatePartOne(), 3749)
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(sut.calculatePartTwo(), 11387)
    }
}

extension Day7Tests {
    func testParsing() throws {
        XCTAssertEqual(
            try sut.equations,
            [
                .init(total: 190, components: [10, 19]),
                .init(total: 3267, components: [81, 40, 27]),
                .init(total: 83, components: [17, 5]),
                .init(total: 156, components: [15, 6]),
                .init(total: 7290, components: [6, 8, 6, 15]),
                .init(total: 161011, components: [16, 10, 13]),
                .init(total: 192, components: [17, 8, 14]),
                .init(total: 21037, components: [9, 7, 18, 13]),
                .init(total: 292, components: [11, 6, 16, 20]),
            ]
        )
    }

    func testCanBeMet() {
        XCTAssertTrue(
            Day7.Equation(
                total: 190,
                components: [10, 19]
            ).canBeMet()
        )
        XCTAssertTrue(
            Day7.Equation(
                total: 3267,
                components: [81, 40, 27]
            ).canBeMet()
        )
        XCTAssertTrue(
            Day7.Equation(
                total: 292,
                components: [11, 6, 16, 20]
            ).canBeMet()
        )
    }

    func testInfixOperator() {
        XCTAssertEqual(12 || 345, 12345)
    }
}

