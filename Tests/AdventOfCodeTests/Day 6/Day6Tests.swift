import XCTest
@testable import AdventOfCode

final class Day6Tests: XCTestCase, SolutionTest {
    typealias SUT = Day6
    
    func testInitialisation() {
        try XCTAssertEqual(
            sut.races,
            [
                Race(time: 7, distance: 9),
                Race(time: 15, distance: 40),
                Race(time: 30, distance: 200)
            ]
        )
    }
    
    func testTimeToTravel() {
        XCTAssertEqual(
            Boat(holdTime: 0).distanceTravelled(in: 7),
            0
        )
        XCTAssertEqual(
            Boat(holdTime: 1).distanceTravelled(in: 7),
            6
        )
        XCTAssertEqual(
            Boat(holdTime: 2).distanceTravelled(in: 7),
            10
        )
    }
    
    func testPartOne() throws {
        try XCTAssertEqual(sut.calculatePartOne(), 288)
    }
    
    func testInitialisationPart2() {
        try XCTAssertEqual(
            sut.racePart2,
            Race(time: 71530, distance: 940200)
        )
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(sut.calculatePartTwo(), 71503)
    }
}
