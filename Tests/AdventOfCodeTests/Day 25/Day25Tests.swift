import XCTest
@testable import AdventOfCode

final class Day25Tests: XCTestCase, SolutionTest {
    typealias SUT = Day25
    
    func testPartOne() throws {
        try XCTAssertEqual(
            sut.calculatePartOne(),
            3
        )
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(sut.calculatePartTwo(), 0)
    }
}

extension Day25Tests {
    func testParsing() throws {
        try XCTAssertEqual(sut.schematics.count, 5)

        try XCTAssertEqual(sut.schematics[0].type, .lock)
        try XCTAssertEqual(sut.schematics[0].entries.values
            .map { $0.map(\.rawValue) }, [
            [".", "#", "#", "#", "#"],
            [".", "#", "#", "#", "#"],
            [".", "#", "#", "#", "#"],
            [".", "#", ".", "#", "."],
            [".", "#", ".", ".", "."]
        ])
        try XCTAssertEqual(sut.schematics[0].pinHeights, [0,5,3,4,3])
        try XCTAssertEqual(sut.schematics[1].type, .lock)
        try XCTAssertEqual(sut.schematics[1].pinHeights, [1,2,0,5,3])

        try XCTAssertEqual(sut.schematics[2].type, .key)
        try XCTAssertEqual(sut.schematics[2].pinHeights, [5,0,2,1,3])
        try XCTAssertEqual(sut.schematics[3].pinHeights, [4,3,4,0,2])
        try XCTAssertEqual(sut.schematics[4].pinHeights, [3,0,2,0,1])
    }

    func testKeys() {
        try XCTAssertEqual(sut.keys.count, 3)
    }

    func testLocks() {
        try XCTAssertEqual(sut.locks.count, 2)
    }
}
