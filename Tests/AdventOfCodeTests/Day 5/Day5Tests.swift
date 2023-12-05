import XCTest
@testable import AdventOfCode

final class Day5Tests: XCTestCase, SolutionTest {
    typealias SUT = Day5
    
    
    
    func testInitialisation() {
        try XCTAssertEqual(
            sut.almanac.seedsToPlant,
            [79, 14, 55, 13]
        )
        try XCTAssertEqual(
            sut.almanac.mappings[0],
            [
                Mapping(sourceStart: 98, destinationStart: 50, length: 2),
                Mapping(sourceStart: 50, destinationStart: 52, length: 48)
            ]
        )
        try XCTAssertEqual(
            sut.almanac.mappings[1],
            [
                Mapping(sourceStart: 15, destinationStart: 0, length: 37),
                Mapping(sourceStart: 52, destinationStart: 37, length: 2),
                Mapping(sourceStart: 0, destinationStart: 39, length: 15)
            ]
        )
        try XCTAssertEqual(
            sut.almanac.mappings.last,
            [
                Mapping(sourceStart: 56, destinationStart: 60, length: 37),
                Mapping(sourceStart: 93, destinationStart: 56, length: 4)
            ]
        )
    }
    
    func testPartOne() throws {
        try XCTAssertEqual(sut.calculatePartOne(), 35)
    }
    
    func testPartTwoInitialisation() throws {
        try XCTAssertEqual(
            sut.almanac.part2Ranges,
            [
                79..<93,
                55..<68
            ]
        )
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(sut.calculatePartTwo(), 46)
    }
}
