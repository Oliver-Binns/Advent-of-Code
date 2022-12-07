import XCTest
@testable import AdventOfCode

final class Day7Tests: XCTestCase, SolutionTest {
    typealias SUT = Day7
    
    func testPartOne() throws {
        try XCTAssertEqual(sut.calculatePartOne(), 95437)
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(sut.calculatePartTwo(), 24933642)
    }
}

extension Day7Tests {
    func testCalculateSize() throws {
        try XCTAssertEqual(sut.state.size, 48381165)
    }
    
    /*func testSubdirectories() throws {
        try XCTAssertEqual(sut.state.subdirectories, [
            ("/", 48381165),
            ("a", 94853),
            ("d", 24933642),
            ("e", 584)
        ])
    }*/
    
    /*func testEdgeCase() throws {
        let state = Output.directory("gsszlj", [
            .file("dsm.hzf", 179837),
            .file("gnrzhsw.jcf", 112354),
            .file("jlwjsbw.bzf", 175236),
            .directory("rvvjbz", [
                .directory("ldglv", [
                    .file("wjwzdg.ldb", 39389)
                ])
            ])
        ])
        
        XCTAssertEqual(state.subdirectories, [
            ("gsszlj", 506816),
            ("ldglv", 39389),
            ("rvvjbz", 39389)
        ])
    }*/
}
