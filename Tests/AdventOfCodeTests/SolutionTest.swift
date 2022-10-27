import XCTest
@testable import AdventOfCode

protocol SolutionTest {
    associatedtype SUT: Solution
}

extension SolutionTest {
    var sut: SUT {
        get throws {
            try SUT(input: getTestData())
        }
    }
    
    func getTestData(filename: String? = nil) throws -> String {
        let input = try XCTUnwrap(Bundle.module
            .url(forResource: filename ?? "Day\(SUT.day)", withExtension: "input"))
        return try String(contentsOf: input)
    }
}
