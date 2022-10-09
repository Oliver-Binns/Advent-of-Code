import XCTest

protocol SolutionTest {
    var day: Int { get }
}

extension SolutionTest {
    func getTestData() throws -> String {
        let input = try XCTUnwrap(Bundle.module
            .url(forResource: "Day\(day)", withExtension: nil))
        return try String(contentsOf: input)
    }
}
