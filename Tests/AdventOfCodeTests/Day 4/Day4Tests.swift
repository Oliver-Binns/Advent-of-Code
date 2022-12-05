import XCTest
@testable import AdventOfCode

final class Day4Tests: XCTestCase, SolutionTest {
    typealias SUT = Day4
    
    func testPartOne() throws {
        try XCTAssertEqual(sut.calculatePartOne(), 2)
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(sut.calculatePartTwo(), 4)
    }
}

extension Day4Tests {
    func testInitialisation() throws {
        try XCTAssertEqual(sut.sections, [
            [2...4, 6...8],
            [2...3, 4...5],
            [5...7, 7...9],
            [2...8, 3...7],
            [6...6, 4...6],
            [2...6, 4...8]
        ])
    }
    
    func testFullyContains() {
        XCTAssertFalse((2...3).fullyContains(4...5))
        XCTAssertFalse((2...6).fullyContains(4...8))
        XCTAssertFalse((22...77).fullyContains(14...96))
        
        XCTAssertTrue((2...8).fullyContains(3...7))
        XCTAssertTrue((4...6).fullyContains(6...6))
        XCTAssertTrue((14...96).fullyContains(22...77))
    }
    
    func testMapping() throws  {
        try XCTAssertEqual(sut.sections.map {
            $0[0].fullyContains($0[1]) ||
            $0[1].fullyContains($0[0])
        }, [false, false, false, true, true, false])
    }
}
