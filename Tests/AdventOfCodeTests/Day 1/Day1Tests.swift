import XCTest
@testable import AdventOfCode

final class Day1Tests: XCTestCase, SolutionTest {
    typealias SUT = Day1
    
    func testPartOne() throws {
        try XCTAssertEqual(sut.calculatePartOne(),
                           2 + 2 + 654 + 33583)
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(sut.calculatePartTwo(), 0)
    }
}

extension Day1Tests {
    func testCalculateFuel() {
        try XCTAssertEqual(sut.calculateFuel(mass: 12), 2)
        try XCTAssertEqual(sut.calculateFuel(mass: 14), 2)
        try XCTAssertEqual(sut.calculateFuel(mass: 1969), 654)
        try XCTAssertEqual(sut.calculateFuel(mass: 100756), 33583)
    }
    
    func testCalculateFuelForFuel() {
        try XCTAssertEqual(sut.calculateFuelForFuel(mass: 14), 2)
        try XCTAssertEqual(sut.calculateFuelForFuel(mass: 1969), 966)
        try XCTAssertEqual(sut.calculateFuelForFuel(mass: 100756), 50346)
    }
    
    func testInitialisation() {
        try XCTAssertEqual(sut.masses, [12, 14, 1969, 100756])
    }
}
