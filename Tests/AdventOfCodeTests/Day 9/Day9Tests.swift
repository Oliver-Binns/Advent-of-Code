import XCTest
@testable import AdventOfCode

final class Day9Tests: XCTestCase, SolutionTest {
    typealias SUT = Day9
    
    func testPartOne() throws {
        try XCTAssertEqual(sut.calculatePartOne(), 1928)
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(sut.calculatePartTwo(), 2858)
    }
}

extension Day9Tests {
    func testParsing() {
        XCTAssertEqual(
            try sut.drive,
            [
                .init(usage: .used(fileID: 0), size: 2),
                .init(usage: .free, size: 3),
                .init(usage: .used(fileID: 1), size: 3),
                .init(usage: .free, size: 3),
                .init(usage: .used(fileID: 2), size: 1),
                .init(usage: .free, size: 3),
                .init(usage: .used(fileID: 3), size: 3),
                .init(usage: .free, size: 1),
                .init(usage: .used(fileID: 4), size: 2),
                .init(usage: .free, size: 1),
                .init(usage: .used(fileID: 5), size: 4),
                .init(usage: .free, size: 1),
                .init(usage: .used(fileID: 6), size: 4),
                .init(usage: .free, size: 1),
                .init(usage: .used(fileID: 7), size: 3),
                .init(usage: .free, size: 1),
                .init(usage: .used(fileID: 8), size: 4),
                .init(usage: .free, size: 0),
                .init(usage: .used(fileID: 9), size: 2)]
        )
    }

    func testRemapDriveSample() {
        XCTAssertEqual(
            try sut.drive.remap()
                .blocks
                .map { $0.description }
                .joined(),
            "0099811188827773336446555566.............."
        )
    }

    func testRemapDriveV2Sample() {
        XCTAssertEqual(
            try sut.drive.remap(preventFragmentation: true)
                .blocks
                .map { $0.description }
                .joined(),
            "00992111777.44.333....5555.6666.....8888.."
        )
    }
}
