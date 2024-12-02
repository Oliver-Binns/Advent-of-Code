import XCTest
@testable import AdventOfCode

final class ReportTests: XCTestCase {
    typealias Report = Day2.Report

    func testIsSafe() {
        XCTAssertTrue(Report(levels: [7, 6, 4, 2, 1]).isSafe())
        XCTAssertFalse(Report(levels: [1, 2, 7, 8, 9]).isSafe())
        XCTAssertFalse(Report(levels: [9, 7, 6, 2, 1]).isSafe())
        XCTAssertFalse(Report(levels: [1, 3, 2, 4, 5]).isSafe())
        XCTAssertFalse(Report(levels: [8, 6, 4, 4, 1]).isSafe())
        XCTAssertTrue(Report(levels: [1, 3, 6, 7, 9]).isSafe())
    }

    func testIsSafeWithDampener() {
        XCTAssertTrue(
            Report(levels: [7, 6, 4, 2, 1])
                .isSafe(problemDampener: true)
        )
        XCTAssertFalse(
            Report(levels: [1, 2, 7, 8, 9])
                .isSafe(problemDampener: true)
        )
        XCTAssertTrue(
            Report(levels: [1, 3, 2, 4, 5])
                .isSafe(problemDampener: true)
        )
        XCTAssertTrue(
            Report(levels: [8, 6, 4, 4, 1])
                .isSafe(problemDampener: true)
        )
    }

    func testDescendingSequenceIsStillSafe() {
        let report = Report(levels: [44, 41, 38, 36, 34, 31, 30])
        XCTAssertTrue(report.isSafe())
        XCTAssertTrue(report.isSafe(problemDampener: true))
    }

    // MARK: - Various Edge Cases found in the report:

    func testDuplicatedStartNumberBecomesSafe() {
        let report = Report(levels: [43, 43, 46, 47, 49, 50, 51])
        XCTAssertFalse(report.isSafe())
        XCTAssertTrue(report.isSafe(problemDampener: true))
    }

    func testDecreasingEndNumberBecomesSafe() {
        let report = Report(levels: [43, 46, 47, 49, 50, 51, 50])
        XCTAssertFalse(report.isSafe())
        XCTAssertTrue(report.isSafe(problemDampener: true))
    }

    func testDuplicatedStartAndEndStillFails() {
        let report = Report(levels: [87, 87, 89, 90, 93, 93])
        XCTAssertFalse(report.isSafe())
        XCTAssertFalse(report.isSafe(problemDampener: true))
    }

    func testStartOutlierBecomesSafe() {
        let report = Report(arrayLiteral: 15, 12, 15, 18, 20, 23, 25, 27)
        XCTAssertFalse(report.isSafe())
        XCTAssertTrue(report.isSafe(problemDampener: true))
    }

    func testEndOutlierBecomesSafe() {
        let report = Report(levels: [32, 35, 36, 38, 42])
        XCTAssertFalse(report.isSafe())
        XCTAssertTrue(report.isSafe(problemDampener: true))
    }

    func testDescendingDuplicatedStartBecomesSafe() {
        let report = Report(levels: [81, 81, 79, 76, 73, 70])
        XCTAssertFalse(report.isSafe())
        XCTAssertTrue(report.isSafe(problemDampener: true))
    }

    func testDescendingEndOutlierBecomesSafe() {
        let report = Report(levels: [80, 79, 78, 75, 72, 70, 71, 70])
        XCTAssertFalse(report.isSafe())
        XCTAssertTrue(report.isSafe(problemDampener: true))
    }

    func testDescendingStartOutlierBecomesSafe() {
        let report = Report(levels: [72, 68, 71, 68, 65, 64])
        XCTAssertFalse(report.isSafe())
        XCTAssertTrue(report.isSafe(problemDampener: true))
    }
}
