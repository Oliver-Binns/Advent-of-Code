import XCTest
@testable import AdventOfCode

final class Day2Tests: XCTestCase, SolutionTest {
    typealias SUT = Day2
    
    func testPartOne() throws {
        try XCTAssertEqual(sut.calculatePartOne(), 15)
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(sut.calculatePartTwo(), 12)
    }
}

extension Day2Tests {
    func testInitialisation() {
        try XCTAssertEqual(sut.gamesPartOne, [
            RPSGame(opposingMove: .rock, yourMove: .paper),
            RPSGame(opposingMove: .paper, yourMove: .rock),
            RPSGame(opposingMove: .scissors, yourMove: .scissors)
        ])
        
        try XCTAssertEqual(sut.gamesPartTwo, [
            RPSGame(opposingMove: .rock, result: .draw),
            RPSGame(opposingMove: .paper, result: .lose),
            RPSGame(opposingMove: .scissors, result: .win)
        ])
    }
    
    func testPlayRound() {
        XCTAssertEqual(RPSGame(opposingMove: .rock, yourMove: .paper).score, 8)
        XCTAssertEqual(RPSGame(opposingMove: .paper, yourMove: .rock).score, 1)
        XCTAssertEqual(RPSGame(opposingMove: .scissors, yourMove: .scissors).score, 6)
    }
}
