import XCTest
@testable import AdventOfCode

final class Day10Tests: XCTestCase, SolutionTest {
    let day = 10
    
    var sut: Day10 {
        get throws {
            try Day10(input: getTestData())
        }
    }
    
    var sutLarger: Day10 {
        get throws {
            try Day10(input: getTestData(filename: "Day10-Larger"))
        }
    }

    func testPartOne() throws {
        try XCTAssertEqual(sut.calculatePartOne(), 35)
        try XCTAssertEqual(sutLarger.calculatePartOne(), 220)
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(sut.calculatePartTwo(), 8)
        try XCTAssertEqual(sutLarger.calculatePartTwo(), 19208)
    }
}

extension Day10Tests {
    func testCalculate() throws {
        let sut = try self.sut
        sut.differences = [1, 1, 1, 3, 3, 2, 2, 2, 1, 1, 3]
        XCTAssertEqual(sut.calculatePartOne(), 15)
    }
    
    func testDifferences() {
        try XCTAssertEqual(
            sut.differences,
            [1, 3, 1, 1, 1, 3, 1, 1, 3, 1, 3, 3]
        )
        
        try XCTAssertEqual(
            sutLarger.differences,
            [1, 1, 1, 1, 3, 1, 1, 1, 1, 3, 3, 1, 1, 1, 3, 1, 1, 3, 3, 1, 1, 1, 1, 3, 1, 3, 3, 1, 1, 1, 1, 3]
        )
    }
}
