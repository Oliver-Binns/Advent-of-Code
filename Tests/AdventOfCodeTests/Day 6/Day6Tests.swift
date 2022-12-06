import XCTest
@testable import AdventOfCode

final class Day6Tests: XCTestCase, SolutionTest {
    typealias SUT = Day6
    
    func testPartOne() throws {
        try XCTAssertEqual(sut.calculatePartOne(), 7)
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(sut.calculatePartTwo(), 19)
    }
}

extension Day6Tests {
    func testAlternativesPartOne() {
        XCTAssertEqual(SUT(input: "bvwbjplbgvbhsrlpgdmjqwftvncz")
            .calculatePartOne(), 5)
        XCTAssertEqual(SUT(input: "nppdvjthqldpwncqszvftbrmjlhg")
            .calculatePartOne(), 6)
        XCTAssertEqual(SUT(input: "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg")
            .calculatePartOne(), 10)
        XCTAssertEqual(SUT(input: "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw")
            .calculatePartOne(), 11)
    }
    
    func testAlternativesPartTwo() {
        XCTAssertEqual(SUT(input: "bvwbjplbgvbhsrlpgdmjqwftvncz")
            .calculatePartTwo(), 23)
        XCTAssertEqual(SUT(input: "nppdvjthqldpwncqszvftbrmjlhg")
            .calculatePartTwo(), 23)
        XCTAssertEqual(SUT(input: "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg")
            .calculatePartTwo(), 29)
        XCTAssertEqual(SUT(input: "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw")
            .calculatePartTwo(), 26)
    }
}
