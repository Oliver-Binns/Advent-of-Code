import XCTest
@testable import AdventOfCode

final class Day8Tests: XCTestCase, SolutionTest {
    typealias SUT = Day8
    
    func testPartOne() throws {
        try XCTAssertEqual(sut.calculatePartOne(), 14)
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(sut.calculatePartTwo(), 34)
    }
}

extension Day8Tests {
    func testParsing() throws {
        XCTAssertEqual(
            try sut.grid.values,
            [
                [".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", "."],
                [".", ".", ".", ".", ".", ".", ".", ".", "0", ".", ".", "."],
                [".", ".", ".", ".", ".", "0", ".", ".", ".", ".", ".", "."],
                [".", ".", ".", ".", ".", ".", ".", "0", ".", ".", ".", "."],
                [".", ".", ".", ".", "0", ".", ".", ".", ".", ".", ".", "."],
                [".", ".", ".", ".", ".", ".", "A", ".", ".", ".", ".", "."],
                [".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", "."],
                [".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", "."],
                [".", ".", ".", ".", ".", ".", ".", ".", "A", ".", ".", "."],
                [".", ".", ".", ".", ".", ".", ".", ".", ".", "A", ".", "."],
                [".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", "."],
                [".", ".", ".", ".", ".", ".", ".", ".", ".", ".", ".", "."],
            ]
        )
    }

    func testAntennaLocations() {
        XCTAssertEqual(
            try sut.antennaLocations,
            [
                "0": [
                    Point(x: 4, y: 4),
                    Point(x: 8, y: 1),
                    Point(x: 7, y: 3),
                    Point(x: 5, y: 2)
                ],
                "A": [
                    Point(x: 8, y: 8),
                    Point(x: 6, y: 5),
                    Point(x: 9, y: 9)
                ]
            ]
        )
    }

    func testCalculateAntinode() {
        XCTAssertEqual(
            try sut.calculateAntinodes(
                between: Point(x: 4, y: 3),
                and: Point(x: 5, y: 5)
            ),
            [Point(x: 3, y: 1)]
        )
    }

    func testAntinodeLocations() {
        XCTAssertEqual(
            try sut.findAntinodes(),
            [
                Point(x: 6,  y: 0),
                Point(x: 11, y: 0),
                Point(x: 3,  y: 1),
                Point(x: 4,  y: 2),
                Point(x: 10, y: 2),
                Point(x: 2,  y: 3),
                Point(x: 9,  y: 4),
                Point(x: 1,  y: 5),
                Point(x: 6,  y: 5),
                Point(x: 3,  y: 6),
                Point(x: 0,  y: 7),
                Point(x: 7,  y: 7),
                Point(x: 10, y: 10),
                Point(x: 10, y: 11)
            ]
        )
    }

    func testUpdatedAntinodeLocations() {
        XCTAssertEqual(
            try sut.findAntinodes(usingUpdatedModel: true),
            [
                Point(x: 0,  y: 0),
                Point(x: 1,  y: 0),
                Point(x: 6,  y: 0),
                Point(x: 11, y: 0),
                Point(x: 1,  y: 1),
                Point(x: 3,  y: 1),
                Point(x: 8,  y: 1),
                Point(x: 2,  y: 2),
                Point(x: 4,  y: 2),
                Point(x: 5,  y: 2),
                Point(x: 10, y: 2),
                Point(x: 2,  y: 3),
                Point(x: 3,  y: 3),
                Point(x: 7,  y: 3),
                Point(x: 4,  y: 4),
                Point(x: 9,  y: 4),
                Point(x: 1,  y: 5),
                Point(x: 5,  y: 5),
                Point(x: 6,  y: 5),
                Point(x: 11, y: 5),
                Point(x: 3,  y: 6),
                Point(x: 6,  y: 6),
                Point(x: 0,  y: 7),
                Point(x: 5,  y: 7),
                Point(x: 7,  y: 7),
                Point(x: 2,  y: 8),
                Point(x: 8,  y: 8),
                Point(x: 4,  y: 9),
                Point(x: 9,  y: 9),
                Point(x: 1,  y: 10),
                Point(x: 10, y: 10),
                Point(x: 3,  y: 11),
                Point(x: 10, y: 11),
                Point(x: 11, y: 11)
            ]
        )
    }
}
