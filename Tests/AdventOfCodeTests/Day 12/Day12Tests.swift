import XCTest
@testable import AdventOfCode

final class Day12Tests: XCTestCase, SolutionTest {
    typealias SUT = Day12
    
    func testPartOne() throws {
        try XCTAssertEqual(sut.calculatePartOne(), 1930)
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(sut.calculatePartTwo(), 1206)
    }
}

extension Day12Tests {
    func testParsing() throws {
        let sut = SUT(input: """
        AAAA
        BBCD
        BBCC
        EEEC
        """)

        XCTAssertEqual(sut.garden.values, [
            ["A", "A", "A", "A"],
            ["B", "B", "C", "D"],
            ["B", "B", "C", "C"],
            ["E", "E", "E", "C"]
        ])
    }

    func testPlots() {
        let sut = SUT(input: """
        AAAA
        BBCD
        BBCC
        EEEC
        """)

        XCTAssertEqual(sut.plots.count, 5)
    }

    func testPlotsLargerSample() throws {
        try XCTAssertEqual(sut.plots.count, 11)
    }

    func testCalculateAreas() {
        XCTAssertEqual(
            try sut.plots.map(sut.calculateArea),
            [12, 4, 14, 10, 13, 11, 1, 13, 14, 5, 3]
        )
    }

    func testCalculatePerimeters() {
        XCTAssertEqual(
            try sut.plots.map(sut.calculatePerimeter),
            [18, 8, 28, 18, 20, 20, 4, 18, 22, 12, 8]
        )
    }
}
