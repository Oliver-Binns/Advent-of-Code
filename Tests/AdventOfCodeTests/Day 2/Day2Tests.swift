import XCTest
@testable import AdventOfCode

final class Day2Tests: XCTestCase, SolutionTest {
    typealias SUT = Day2
    
    func testInitialisation() throws {
        try XCTAssertEqual(sut.games.count, 5)
        try XCTAssertEqual(
            sut.games.first,
            Day2.Game(id: 1, rounds: [
                [.blue: 3, .red: 4],
                [.red: 1, .green: 2, .blue: 6],
                [.green: 2]
            ])
        )
    }
    
    func testRoundIsPossible() {
        let totalCubes = [Day2.Cube.red: 12, .green: 13, .blue: 14]
        XCTAssertTrue([.red: 1, .green: 2, .blue: 6]
            .isPossible(with: totalCubes)
        )
        XCTAssertTrue([.red: 12, .green: 13, .blue: 14]
            .isPossible(with: totalCubes)
        )
        XCTAssertFalse([.red: 13, .green: 13, .blue: 14]
            .isPossible(with: totalCubes)
        )
        XCTAssertFalse([.red: 12, .green: 14, .blue: 14]
            .isPossible(with: totalCubes)
        )
        XCTAssertFalse([.red: 12, .green: 13, .blue: 15]
            .isPossible(with: totalCubes)
        )
    }
    
    func testGameIsPossible() {
        let totalCubes = [Day2.Cube.red: 12, .green: 13, .blue: 14]
        try XCTAssertTrue(sut.games[0].isPossible(with: totalCubes))
        try XCTAssertTrue(sut.games[1].isPossible(with: totalCubes))
        try XCTAssertFalse(sut.games[2].isPossible(with: totalCubes))
        try XCTAssertFalse(sut.games[3].isPossible(with: totalCubes))
        try XCTAssertTrue(sut.games[4].isPossible(with: totalCubes))
    }
    
    func testPartOne() throws {
        try XCTAssertEqual(sut.calculatePartOne(), 8)
    }
    
    func testMinCubes() throws {
        try XCTAssertEqual(
            sut.games[0].minCubes,
            [.red: 4, .green: 2, .blue: 6]
        )
        try XCTAssertEqual(
            sut.games[1].minCubes,
            [.red: 1, .green: 3, .blue: 4]
        )
    }
    
    func testPower() {
        XCTAssertEqual(
            [.red: 4, .green: 2, .blue: 6].power,
            48
        )
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(sut.calculatePartTwo(), 2286)
    }
}
