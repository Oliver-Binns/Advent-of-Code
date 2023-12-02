import XCTest
@testable import AdventOfCode

final class Day1Tests: XCTestCase, SolutionTest {
    typealias SUT = Day1
    
    var sut2: SUT {
        get throws {
            let input = try getTestData(filename: "Day1-Part2")
            return Day1(input: input)
        }
    }
    
    func testInitialisation() {
        try XCTAssertEqual(
            sut.lines,
            [
                "1abc2",
                "pqr3stu8vwx",
                "a1b2c3d4e5f",
                "treb7uchet"
            ]
        )
    }
}

// MARK: - Part 1 Tests
extension Day1Tests {
    
    func testStartsWith() {
        try XCTAssertEqual(
            sut.checkEndOfString("1abc2", 
                                 indexPath: \.startIndex,
                                 find: string(_:hasPrefix:)),
            "1"
        )
        try XCTAssertNil(
            sut.checkEndOfString("pqr3stu8vwx",
                                 indexPath: \.startIndex,
                                 find: string(_:hasPrefix:))
        )
        try XCTAssertEqual(
            sut.checkEndOfString("3stu8vwx",
                                 indexPath: \.startIndex,
                                 find: string(_:hasPrefix:)),
            "3"
        )
    }
    
    func testEndsWith() {
        try XCTAssertEqual(
            sut.checkEndOfString("1abc2",
                                 indexPath: \.lastIndex,
                                 find: string(_:hasSuffix:)),
            "2"
        )
        try XCTAssertNil(
            sut.checkEndOfString("pqr3stu8vwx",
                                 indexPath: \.lastIndex,
                                 find: string(_:hasSuffix:))
        )
        try XCTAssertEqual(
            sut.checkEndOfString("3stu8",
                                 indexPath: \.lastIndex,
                                 find: string(_:hasSuffix:),
                                 isPartTwo: true),
            "8"
        )
    }
    
    func testFirstNumber() {
        try XCTAssertEqual(sut.searchString("1abc2", direction: .forward), "1")
        try XCTAssertEqual(sut.searchString("pqr3stu8vwx", direction: .forward), "3")
        try XCTAssertEqual(sut.searchString("a1b2c3d4e5f", direction: .forward), "1")
        try XCTAssertEqual(sut.searchString("treb7uchet", direction: .forward), "7")
    }
    
    func testLastNumber() {
        try XCTAssertEqual(sut.searchString("1abc2", direction: .backward), "2")
        try XCTAssertEqual(sut.searchString("pqr3stu8vwx", direction: .backward), "8")
        try XCTAssertEqual(sut.searchString("a1b2c3d4e5f", direction: .backward), "5")
        try XCTAssertEqual(sut.searchString("treb7uchet", direction: .backward), "7")
    }
    
    func testPartOne() throws {
        try XCTAssertEqual(sut.calculatePartOne(), 142)
    }
}

// MARK: - Part 2 Tests
extension Day1Tests {
    func testStartsWithPartTwo() {
        try XCTAssertNil(
            sut.checkEndOfString("two1nine",
                                 indexPath: \.startIndex,
                                 find: string(_:hasPrefix:))
        )
        try XCTAssertEqual(
            sut.checkEndOfString("two1nine",
                                 indexPath: \.startIndex,
                                 find: string(_:hasPrefix:),
                                 isPartTwo: true),
            "2"
        )
        
        try XCTAssertNil(
            sut.checkEndOfString("eightwothree",
                                 indexPath: \.startIndex,
                                 find: string(_:hasPrefix:))
        )
        try XCTAssertEqual(
            sut.checkEndOfString("eightwothree",
                                 indexPath: \.startIndex,
                                 find: string(_:hasPrefix:),
                                 isPartTwo: true),
            "8"
        )
        
        try XCTAssertNil(
            sut.checkEndOfString("abcone2threexyz",
                                 indexPath: \.startIndex,
                                 find: string(_:hasPrefix:))
        )
        try XCTAssertNil(
            sut.checkEndOfString("abcone2threexyz",
                                 indexPath: \.startIndex,
                                 find: string(_:hasPrefix:),
                                 isPartTwo: true)
        )
    }
    
    func testFirstNumberPartTwo() {
        try XCTAssertEqual(
            sut.searchString("abcone2threexyz", direction: .forward),
            "2"
        )
        try XCTAssertEqual(
            sut.searchString("abcone2threexyz", direction: .forward, isPartTwo: true),
            "1"
        )
    }
    
    func testEndsWithPartTwo() {
        try XCTAssertNil(
            sut.checkEndOfString("two1nine",
                                 indexPath: \.lastIndex,
                                 find: string(_:hasSuffix:))
        )
        try XCTAssertEqual(
            sut.checkEndOfString("two1nine",
                                 indexPath: \.lastIndex,
                                 find: string(_:hasSuffix:),
                                 isPartTwo: true),
            "9"
        )
        
        try XCTAssertNil(
            sut.checkEndOfString("eightwothree",
                                 indexPath: \.lastIndex,
                                 find: string(_:hasSuffix:))
        )
        try XCTAssertEqual(
            sut.checkEndOfString("eightwothree",
                                 indexPath: \.lastIndex,
                                 find: string(_:hasSuffix:),
                                 isPartTwo: true),
            "3"
        )
        
        try XCTAssertNil(
            sut.checkEndOfString("abcone2threexyz",
                                 indexPath: \.lastIndex,
                                 find: string(_:hasSuffix:))
        )
        try XCTAssertNil(
            sut.checkEndOfString("abcone2threexyz",
                                 indexPath: \.lastIndex,
                                 find: string(_:hasSuffix:),
                                 isPartTwo: true)
        )
    }
    
    func testLastNumberPartTwo() {
        try XCTAssertEqual(
            sut.searchString("abcone2threexyz", direction: .backward),
            "2"
        )
        try XCTAssertEqual(
            sut.searchString("abcone2threexyz", direction: .backward, isPartTwo: true),
            "3"
        )
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(sut2.calculatePartTwo(), 281)
    }
}

extension Day1Tests {
    func string(_ string: String, hasPrefix prefix: String) -> Bool {
        string.hasPrefix(prefix)
    }
    
    func string(_ string: String, hasSuffix suffix: String) -> Bool {
        string.hasSuffix(suffix)
    }
}
