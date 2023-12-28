@testable import AdventOfCode
import XCTest

final class TerrainTests: XCTestCase {
    func testInitialisation() {
        let sut = Terrain()
        XCTAssertEqual(
            sut.coordinates,
            [Coordinate(x: 0, y: 0)]
        )
    }
    
    func testDig() {
        let sut = Terrain()
            .dig(instruction: DigInstruction(direction: .right, distance: 6))
        
        XCTAssertEqual(
            sut.coordinates,
            [
                Coordinate(x: 0, y: 0),
                Coordinate(x: 7, y: 0),
            ]
        )
    }
    
    func testLineArea() {
        let sut = Terrain()
            .dig(instruction: DigInstruction(direction: .right, distance: 1))
        
        print(sut.coordinates)
        XCTAssertEqual(sut.cubicMeters, 6)
    }
    
    func testSquareArea() {
        let sut = Terrain()
            .dig(instruction: DigInstruction(direction: .right, distance: 1))
            .dig(instruction: DigInstruction(direction: .down, distance: 1))
            .dig(instruction: DigInstruction(direction: .left, distance: 1))
            .dig(instruction: DigInstruction(direction: .up, distance: 1))
        
        XCTAssertEqual(sut.cubicMeters, 4)
    }
    
    func testInsetArea() {
        let sut = Terrain()
            .dig(instruction: DigInstruction(direction: .right, distance: 5))
            .dig(instruction: DigInstruction(direction: .down, distance: 3))
            .dig(instruction: DigInstruction(direction: .left, distance: 1))
            .dig(instruction: DigInstruction(direction: .up, distance: 2))
            .dig(instruction: DigInstruction(direction: .left, distance: 3))
            .dig(instruction: DigInstruction(direction: .down, distance: 2))
            .dig(instruction: DigInstruction(direction: .left, distance: 1))
            .dig(instruction: DigInstruction(direction: .up, distance: 3))
        
        XCTAssertEqual(sut.cubicMeters, 20)
    }
}
