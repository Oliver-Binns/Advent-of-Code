import XCTest
@testable import AdventOfCode

final class Day3Tests: XCTestCase, SolutionTest {
    typealias SUT = Day3
    
    func testSymbolInitialisation() {
        try XCTAssertEqual(
            sut.schematic.symbols,
            [
                Coordinate(x: 3, y: 1) : "*",
                Coordinate(x: 6, y: 3) : "#",
                Coordinate(x: 3, y: 4) : "*",
                Coordinate(x: 5, y: 5) : "+",
                Coordinate(x: 3, y: 8): "$",
                Coordinate(x: 5, y: 8): "*"
            ]
        )
    }
    
    func testNumbersInitialisation() {
        try XCTAssertEqual(
            sut.schematic.numbers.count,
            10
        )
        try XCTAssertEqual(
            sut.schematic.numbers.map(\.value),
            [
                467,
                114,
                35,
                633,
                617,
                58,
                592,
                755,
                664,
                598
            ]
        )
        
        try XCTAssertEqual(
            sut.schematic.numbers.first?.location,
            .init(row: 0, columns: 0...2)
        )
        
        try XCTAssertEqual(
            sut.schematic.numbers.last?.location,
            .init(row: 9, columns: 5...7)
        )
    }
    
    func testNumberLocationSurroundingCoordinates() {
        XCTAssertEqual(
            NumberLocation(row: 3, columns: 2...3)
                .surroundingCoordinates,
            [
                Coordinate(x: 1, y: 2),
                Coordinate(x: 2, y: 2),
                Coordinate(x: 3, y: 2),
                Coordinate(x: 4, y: 2),
                
                Coordinate(x: 1, y: 3),
                Coordinate(x: 4, y: 3),
                
                Coordinate(x: 1, y: 4),
                Coordinate(x: 2, y: 4),
                Coordinate(x: 3, y: 4),
                Coordinate(x: 4, y: 4),
            ]
        )
    }
    
    func testPartOne() throws {
        try XCTAssertEqual(sut.calculatePartOne(), 4361)
    }
    
    func testSurroundingCoordinates() {
        XCTAssertEqual(
            Coordinate(x: 2, y: 2).surroundingCoordinates,
            [
                Coordinate(x: 1, y: 1),
                Coordinate(x: 2, y: 1),
                Coordinate(x: 3, y: 1),
                
                Coordinate(x: 1, y: 2),
                Coordinate(x: 3, y: 2),
                
                Coordinate(x: 1, y: 3),
                Coordinate(x: 2, y: 3),
                Coordinate(x: 3, y: 3),
                
            ]
        )
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(sut.calculatePartTwo(), 467835)
    }
}
