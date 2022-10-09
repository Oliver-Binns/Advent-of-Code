import XCTest

protocol SolutionTest {
    var day: Int { get }
}

extension SolutionTest {
    func getTestData(filename: String? = nil) throws -> String {
        let input = try XCTUnwrap(Bundle.module
            .url(forResource: filename ?? "Day\(day)", withExtension: nil))
        return try String(contentsOf: input)
    }
}
