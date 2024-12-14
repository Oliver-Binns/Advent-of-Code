import XCTest
@testable import AdventOfCode

final class Day13Tests: XCTestCase, SolutionTest {
    typealias SUT = Day13
    
    func testPartOne() throws {
        try XCTAssertEqual(sut.calculatePartOne(), 480)
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(sut.calculatePartTwo(), 0)
    }
}

extension Day13Tests {
    func testParsing() throws {
        XCTAssertEqual(
            try sut.machines.count,
            4
        )
        XCTAssertEqual(
            try sut.machines[0],
            ClawMachine(
                buttonA: Point(x: 94, y: 34),
                buttonB: Point(x: 22, y: 67),
                prize: Point(x: 8400, y: 5400)
            )
        )
    }

    func testWinOptions() throws {
        XCTAssertEqual(
            try sut.winOptions(for: sut.machines[0]).count,
            1
        )
        XCTAssertEqual(
            try sut.winOptions(for: sut.machines[0])[0].x,
            80 * 3
        )
        XCTAssertEqual(
            try sut.winOptions(for: sut.machines[0])[0].y,
            40
        )
    }
}
//Button A: X+94, Y+34
//Button B: X+22, Y+67
//Prize: X=8400, Y=5400
