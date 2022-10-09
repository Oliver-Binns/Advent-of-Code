import XCTest
@testable import AdventOfCode

final class Day1Tests: XCTestCase {
    func testSolution() throws {
        let input = try XCTUnwrap(Bundle(for: Self.self)
            .url(forResource: "Day1", withExtension: nil))
        let fileContents = try String(contentsOf: input)
        XCTAssertEqual(Day1(input: fileContents).calculatePartOne(), "514579")
    }
}
