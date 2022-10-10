import XCTest
@testable import AdventOfCode

final class Day13Tests: XCTestCase, SolutionTest {
    let day = 13
    
    func testPartOne() throws {
        try XCTAssertEqual(Day13(input: getTestData()).calculatePartOne(), 295)
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(Day13(input: getTestData()).calculatePartTwo(), 0)
    }
}

extension Day13Tests {
    func testInitialisation() throws {
        let sut = try Day13(input: getTestData())
        XCTAssertEqual(sut.earliestDeparture, 939)
        XCTAssertEqual(sut.buses, [7, 13, nil, nil, 59, nil, 31, 19])
    }
    
    func testNextDepartureCalculation() throws {
        let sut = try Day13(input: getTestData())
        XCTAssertEqual(sut.nextDeparture(ofBus:  7, after: 929), 931)
        XCTAssertEqual(sut.nextDeparture(ofBus: 13, after: 929), 936)
        XCTAssertEqual(sut.nextDeparture(ofBus: 59, after: 929), 944)
        XCTAssertEqual(sut.nextDeparture(ofBus: 31, after: 929), 930)
        XCTAssertEqual(sut.nextDeparture(ofBus: 19, after: 929), 931)
    }
}
