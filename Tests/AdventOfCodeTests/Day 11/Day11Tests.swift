import XCTest
@testable import AdventOfCode

final class Day11Tests: XCTestCase, SolutionTest {
    typealias SUT = Day11
    
    func testPartOne() throws {
        try XCTAssertEqual(sut.calculatePartOne(), 55312)
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(sut.calculatePartTwo(), 65601038650482)
    }
}

extension Day11Tests {
    func testParsing() throws {
        try XCTAssertEqual(
            sut.stones,
            [
                125: 1,
                17: 1
            ]
        )
    }
    
    func testBlinkRule1() throws {
        let blinkedStones = try sut.blink(stones: [0: 1])
        // Rule 1:
        // If the stone is engraved with the number 0,
        // it is replaced by a stone engraved with the number 1.
        XCTAssertEqual(blinkedStones[0, default: 0], 0)
        XCTAssertEqual(blinkedStones[1, default: 0], 1)
    }
    
    func testBlinkRule2() throws {
        let blinkedStones = try sut.blink(stones: [10: 1, 99: 1])
        // Rule 2:
        // If the stone is engraved with a number that has an even
        // number of digits, it is replaced by two stones.
        //
        // The left half of the digits are engraved on the new left
        // stone, and the right half of the digits are engraved on
        // the new right stone. (The new numbers don't keep extra
        // leading zeroes: 1000 would become stones 10 and 0.)
        XCTAssertEqual(blinkedStones[0], 1)
        XCTAssertEqual(blinkedStones[1], 1)
        XCTAssertEqual(blinkedStones[9], 2)
    }
    
    func testBlinkRule3() throws {
        let blinkedStones = try sut.blink(stones: [1: 1, 999: 1])
        // Rule 3:
        // If none of the other rules apply, the stone is replaced
        // by a new stone; the old stone's number multiplied by 2024
        // is engraved on the new stone.
        XCTAssertEqual(blinkedStones[2024], 1)
        XCTAssertEqual(blinkedStones[2021976], 1)
    }
    
    func testSixBlinks() throws {
        let blinkedStones = try sut.blink(
            times: 6,
            stones: [125: 1, 17: 1]
        )
        
        XCTAssertEqual(
            blinkedStones.values.reduce(0, +),
            22
        )
    }
}
