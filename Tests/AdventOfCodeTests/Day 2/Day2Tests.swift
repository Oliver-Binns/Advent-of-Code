import XCTest
@testable import AdventOfCode

final class Day2Tests: XCTestCase, SolutionTest {
    typealias SUT = Day2
    
    func testPartOne() throws {
        try XCTAssertEqual(sut
            .calculatePartOne(replacingValues: false), 3500)
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(sut.calculatePartTwo(), 0)
    }
}

extension Day2Tests {
    func testInitialisation() {
        try XCTAssertEqual(sut.program.state,
                           [1,9,10,3,2,3,11,0,99,30,40,50])
    }
    
    func testRunNextInstruction() throws {
        let state = try sut.program
        XCTAssertEqual(state.runInstruction(0)?.state,
                       [1,9,10,70,
                        2,3,11,0,
                        99,
                        30,40,50])
        
        XCTAssertEqual(state.runInstruction(0)?.runInstruction(4)?.state,
                       [3500,9,10,70,
                        2,3,11,0,
                        99,
                        30,40,50])
    }
    
    func testExamples() {
        XCTAssertEqual(SUT(input: "1,0,0,0,99")
            .calculatePartOne(replacingValues: false), 2)
        XCTAssertEqual(SUT(input: "2,3,0,3,99")
            .calculatePartOne(replacingValues: false), 2)
        XCTAssertEqual(SUT(input: "2,4,4,5,99,0")
            .calculatePartOne(replacingValues: false), 2)
        XCTAssertEqual(SUT(input: "1,1,1,4,99,5,6,0,99")
            .calculatePartOne(replacingValues: false), 30)
    }
}
