import XCTest
@testable import AdventOfCode

final class Day11Tests: XCTestCase, SolutionTest {
    typealias SUT = Day11
    
    func testPartOne() throws {
        try XCTAssertEqual(sut.calculatePartOne(), 10605)
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(sut.calculatePartTwo(), 2713310158)
    }
}

extension Day11Tests {
    func testInitialisation() throws {
        let monkeys = try sut.monkeys
        XCTAssertEqual(monkeys.count, 4)
        
        XCTAssertEqual(monkeys[0].items, [79, 98])
        XCTAssertEqual(monkeys[1].items, [54, 65, 75, 74])
        XCTAssertEqual(monkeys[2].items, [79, 60, 97])
        XCTAssertEqual(monkeys[3].items, [74])
        
        XCTAssertEqual(monkeys[0].operation(0), 0)
        XCTAssertEqual(monkeys[0].operation(1), 19)
        XCTAssertEqual(monkeys[0].operation(2), 38)
        
        XCTAssertEqual(monkeys[1].operation(0), 6)
        XCTAssertEqual(monkeys[1].operation(1), 7)
        XCTAssertEqual(monkeys[1].operation(2), 8)
        
        XCTAssertEqual(monkeys[2].operation(0), 0)
        XCTAssertEqual(monkeys[2].operation(1), 1)
        XCTAssertEqual(monkeys[2].operation(2), 4)
        
        XCTAssertEqual(monkeys[3].operation(0), 3)
        XCTAssertEqual(monkeys[3].operation(1), 4)
        XCTAssertEqual(monkeys[3].operation(2), 5)
        
        XCTAssertEqual(
            monkeys[0].test,
            .init(divisibleBy: 23, ifTrue: 2, ifFalse: 3)
        )
        XCTAssertEqual(
            monkeys[1].test,
            .init(divisibleBy: 19, ifTrue: 2, ifFalse: 0)
        )
        XCTAssertEqual(
            monkeys[2].test,
            .init(divisibleBy: 13, ifTrue: 1, ifFalse: 3)
        )
        XCTAssertEqual(
            monkeys[3].test,
            .init(divisibleBy: 17, ifTrue: 0, ifFalse: 1)
        )
    }
    
    func testInspectItems() throws {
        let monkeys = try sut.inspectItems(monkeys: sut.monkeys)
        
        XCTAssertEqual(monkeys.count, 4)
        XCTAssertEqual(monkeys[0].items, [20, 23, 27, 26])
        XCTAssertEqual(monkeys[1].items, [2080, 25, 167, 207, 401, 1046])
        XCTAssertTrue(monkeys[2].items.isEmpty)
        XCTAssertTrue(monkeys[3].items.isEmpty)
    }
}
