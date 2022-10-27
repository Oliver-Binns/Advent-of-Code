import XCTest
@testable import AdventOfCode

final class Day14Tests: XCTestCase, SolutionTest {
    let day = 14
    
    func testPartOne() throws {
        try XCTAssertEqual(Day14(input: getTestData()).calculatePartOne(), 165)
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(Day14(input: getTestData()).calculatePartTwo(), 208)
    }
}

extension Day14Tests {
    func testInitialisation() throws {
        let sut = try Day14(input: getTestData())
        XCTAssertEqual(sut.instructions, [
            .mask(.init(string: "XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X")),
            .write(.init(address: 8, value: 11)),
            .write(.init(address: 7, value: 101)),
            .write(.init(address: 8, value: 0)),
        ])
    }
    
    func testSum() {
        XCTAssertEqual(InitialisationPart1(memory: [7: 101, 8: 64]).sum, 165)
    }
    
    func testWrite() throws {
        var sut = InitialisationPart1(currentMask: .init(string: "XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X"),
                                 memory: [:])
        sut.apply(instruction: .write(.init(address: 8, value: 11)))
        sut.apply(instruction: .write(.init(address: 7, value: 101)))
        sut.apply(instruction: .write(.init(address: 8, value: 0)))
        XCTAssertEqual(sut.memory, [7: 101, 8: 64])
    }
    
    func testMask() {
        let mask = Mask(string: "XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X")
        
        var sut = InitialisationPart1(memory: [:])
        sut.apply(instruction: .mask(mask))
        XCTAssertEqual(sut.currentMask, mask)
    }
    
    func testApplyingMask() {
        let mask = Mask(string: "XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X")
        XCTAssertEqual(MaskApplicatorV1.apply(mask: mask, to: 11), 73)
    }
    
    func testApplyingMask2() {
        let mask = Mask(string: "000000000000000000000000000000X1001X")
        XCTAssertEqual(MaskApplicatorV2.apply(mask: mask, to: 42),
                       [26, 27, 58, 59])
    }
}
