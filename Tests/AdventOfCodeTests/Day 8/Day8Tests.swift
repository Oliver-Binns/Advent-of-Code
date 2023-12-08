import XCTest
@testable import AdventOfCode

final class Day8Tests: XCTestCase, SolutionTest {
    typealias SUT = Day8
    
    func testInitialisation() {
        try XCTAssertEqual(
            sut.instructions,
            [.right, .left]
        )
        try XCTAssertEqual(
            sut.map, 
            [
                "AAA": Node(left: "BBB", right: "CCC"),
                "BBB": Node(left: "DDD", right: "EEE"),
                "CCC": Node(left: "ZZZ", right: "GGG"),
                "DDD": Node(left: "DDD", right: "DDD"),
                "EEE": Node(left: "EEE", right: "EEE"),
                "GGG": Node(left: "GGG", right: "GGG"),
                "ZZZ": Node(left: "ZZZ", right: "ZZZ"),
            ]
        )
    }
    
    func testPartOne() throws {
        try XCTAssertEqual(sut.calculatePartOne(), 2)
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(sut.calculatePartTwo(), 0)
    }
}
