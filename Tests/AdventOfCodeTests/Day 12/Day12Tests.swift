import XCTest
@testable import AdventOfCode

final class Day12Tests: XCTestCase, SolutionTest {
    typealias SUT = Day12
    
    func testInitialisationOfRows() {
        try XCTAssertEqual(
            sut.rows,
            [
                Row(springs: ["?", "?", "?", ".", "#",
                              "#", "#"],
                    groups: [1,1,3]),
                
                Row(springs: [".", "?", "?", ".", ".",
                              "?", "?", ".", ".", ".",
                              "?", "#", "#", "."],
                    groups: [1,1,3]),
                
                Row(springs: ["?", "#", "?", "#", "?",
                              "#", "?", "#", "?", "#",
                              "?", "#", "?", "#", "?"], 
                    groups: [1,3,1,6]),
                
                Row(springs: ["?", "?", "?", "?", ".",
                              "#", ".", ".", ".", "#",
                              ".", ".", "."],
                    groups: [4,1,1]),
                
                Row(springs: ["?", "?", "?", "?", ".",
                              "#", "#", "#", "#", "#",
                              "#", ".", ".", "#", "#",
                              "#", "#", "#", "."],
                    groups: [1,6,5]),
                
                Row(springs: ["?", "#", "#", "#", "?",
                              "?", "?", "?", "?", "?",
                              "?", "?"],
                    groups: [3,2,1]),
            ]
        )
    }
    
    func testRequiredGroups() {
        try XCTAssertEqual(
            sut.rows[0].requiredGroups,
            ["#", ".", "#", ".", "#", "#", "#"]
        )
    }
    
    func testRemoveTopSprings() {
        let row = Row(springs: [], groups: [])
        let (groups, springs) = row
            .removeTopSprings(for: [.damaged, .damaged, .damaged, .operational, .operational, .damaged],
                              in: [.damaged, .unknown, .damaged, .operational])
        
        XCTAssertEqual(
            groups,
            [.operational, .operational, .damaged]
        )
        XCTAssertEqual(
            springs,
            [.operational]
        )
    }
    
    func testEachRow() {
        try XCTAssertEqual(
            sut.rows[0].possibleArrangements,
            1
        )
        try XCTAssertEqual(
            sut.rows[1].possibleArrangements,
            4
        )
        try XCTAssertEqual(
            sut.rows[2].possibleArrangements,
            1
        )
        try XCTAssertEqual(
            sut.rows[3].possibleArrangements,
            1
        )
        try XCTAssertEqual(
            sut.rows[4].possibleArrangements,
            4
        )
        try XCTAssertEqual(
            sut.rows[5].possibleArrangements,
            10
        )
    }
    
    func testPartOne() throws {
        try XCTAssertEqual(sut.calculatePartOne(), 21)
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(sut.calculatePartTwo(), 0)
    }
}
// 3357 too low
