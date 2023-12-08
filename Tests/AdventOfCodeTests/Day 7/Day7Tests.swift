import XCTest
@testable import AdventOfCode

final class Day7Tests: XCTestCase, SolutionTest {
    typealias SUT = Day7
    
    func testInitialisation() {
        try XCTAssertEqual(sut.players.count, 5)
        try XCTAssertEqual(
            sut.players[0].0,
            Hand(cards: [.three, .two, .ten, .three, .king])
        )
        try XCTAssertEqual(sut.players[0].1, 765)
    }
    
    func testHandTypes() {
        XCTAssertEqual(
            Hand(cards: [.two, .two, .two, .two, .two]).type,
            .fiveOfAKind
        )
        XCTAssertEqual(
            Hand(cards: [.two, .two, .two, .two, .three]).type,
            .fourOfAKind
        )
        XCTAssertEqual(
            Hand(cards: [.two, .two, .two, .five, .five]).type,
            .fullHouse
        )
        XCTAssertEqual(
            Hand(cards: [.two, .two, .two, .five, .three]).type,
            .threeOfAKind
        )
        XCTAssertEqual(
            Hand(cards: [.two, .two, .five, .five, .three]).type,
            .twoPair
        )
        XCTAssertEqual(
            Hand(cards: [.two, .two, .five, .ace, .three]).type,
            .onePair
        )
        XCTAssertEqual(
            Hand(cards: [.ace, .king, .queen, .jack, .ten]).type,
            .highCard
        )
    }
    
    func testCompareHandTypes() {
        XCTAssertGreaterThan(HandType.fiveOfAKind, .fourOfAKind)
        XCTAssertGreaterThan(HandType.fourOfAKind, .fullHouse)
        XCTAssertGreaterThan(HandType.fullHouse, .threeOfAKind)
        XCTAssertGreaterThan(HandType.threeOfAKind, .twoPair)
        XCTAssertGreaterThan(HandType.twoPair, .onePair)
        XCTAssertGreaterThan(HandType.onePair, .highCard)
        
        XCTAssertEqual(HandType.fiveOfAKind, .fiveOfAKind)
    }
    
    func testPartOne() throws {
        try XCTAssertEqual(sut.calculatePartOne(), 6440)
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(sut.calculatePartTwo(), 0)
    }
}
