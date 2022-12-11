import XCTest
@testable import AdventOfCode

final class Day10Tests: XCTestCase, SolutionTest {
    typealias SUT = Day10
    
    func testPartOne() throws {
        try XCTAssertEqual(sut.calculatePartOne(), 13140)
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(sut.calculatePartTwo(), """
        
        
        ##..##..##..##..##..##..##..##..##..##..
        ###...###...###...###...###...###...###.
        ####....####....####....####....####....
        #####.....#####.....#####.....#####.....
        ######......######......######......####
        #######.......#######.......#######.....
        """)
    }
}

extension Day10Tests {
    func testInitialisation() {
        let sut = SUT(input: """
        noop
        addx 3
        addx -5
        """)
        
        XCTAssertEqual(sut.instructions, [
            .noOperation,
            .add(3),
            .add(-5)
        ])
    }
    
    func testRunNoOp() {
        let cpu = Day10.CPU()
        XCTAssertEqual(cpu.register, 1)
        
        let firstCycle = cpu
            .runInstruction(.noOperation)
        XCTAssertEqual(firstCycle.count, 1)
        XCTAssertEqual(firstCycle.first?.register, 1)
    }
    
    func testRunAddX() {
        let cpu = Day10.CPU()
        XCTAssertEqual(cpu.register, 1)
        
        let firstCycle = cpu
            .runInstruction(.add(3))
        XCTAssertEqual(firstCycle.count, 2)
        XCTAssertEqual(firstCycle.first?.register, 1)
        XCTAssertEqual(firstCycle.last?.register, 4)
    }
    
    func testAllStates() {
        let sut = SUT(input: """
        noop
        addx 3
        addx -5
        """)
        
        let allStates = sut.allStates
        XCTAssertEqual(allStates.count, 6)
        XCTAssertEqual(allStates[0].register, 1)
        XCTAssertEqual(allStates[1].register, 1)
        XCTAssertEqual(allStates[2].register, 1)
        XCTAssertEqual(allStates[3].register, 4)
        XCTAssertEqual(allStates[4].register, 4)
        XCTAssertEqual(allStates[5].register, -1)
    }
}
