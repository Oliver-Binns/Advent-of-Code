import XCTest
@testable import AdventOfCode

final class Day10Tests: XCTestCase, SolutionTest {
    typealias SUT = Day10
    
    func testPartOne() throws {
        try XCTAssertEqual(sut.calculatePartOne(), 36)
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(sut.calculatePartTwo(), 81)
    }
}

extension Day10Tests {
    func testParsing() throws {
        XCTAssertEqual(
            try sut.grid,
            Grid(values: [
                [8, 9, 0, 1, 0, 1, 2, 3],
                [7, 8, 1, 2, 1, 8, 7, 4],
                [8, 7, 4, 3, 0, 9, 6, 5],
                [9, 6, 5, 4, 9, 8, 7, 4],
                [4, 5, 6, 7, 8, 9, 0, 3],
                [3, 2, 0, 1, 9, 0, 1, 2],
                [0, 1, 3, 2, 9, 8, 0, 1],
                [1, 0, 4, 5, 6, 7, 3, 2],
            ])
        )
    }
    
    func testSmallerGrid() {
        let sut = Day10(input: """
        0123
        1234
        8765
        9876
        """)
        
        XCTAssertEqual(sut.calculatePartOne(), 1)
    }
    
    func testCountPaths() {
        XCTAssertEqual(
            try sut.findHighpointsReachable(from: Point(x: 2, y: 1)).count,
            10
        )
    }
}
