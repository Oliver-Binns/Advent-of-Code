import XCTest
@testable import AdventOfCode

final class RPSTests: XCTestCase {
    func testPlay() {
        XCTAssertEqual(RPSGame(opposingMove: .paper, yourMove: .rock).result, .lose)
        XCTAssertEqual(RPSGame(opposingMove: .scissors, yourMove: .rock).result, .win)
        XCTAssertEqual(RPSGame(opposingMove: .rock, yourMove: .rock).result, .draw)
        
        XCTAssertEqual(RPSGame(opposingMove: .scissors, yourMove: .paper).result, .lose)
        XCTAssertEqual(RPSGame(opposingMove: .rock, yourMove: .paper).result, .win)
        XCTAssertEqual(RPSGame(opposingMove: .paper, yourMove: .paper).result, .draw)
        
        XCTAssertEqual(RPSGame(opposingMove: .rock, yourMove: .scissors).result, .lose)
        XCTAssertEqual(RPSGame(opposingMove: .paper, yourMove: .scissors).result, .win)
        XCTAssertEqual(RPSGame(opposingMove: .scissors, yourMove: .scissors).result, .draw)
    }
}
