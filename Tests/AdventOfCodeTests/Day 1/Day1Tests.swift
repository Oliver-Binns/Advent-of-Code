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
            sut.startsWith(string: "1abc2"),
            "1"
        )
        try XCTAssertNil(
            sut.startsWith(string: "pqr3stu8vwx")
        )
        try XCTAssertEqual(
            sut.startsWith(string: "3stu8vwx"),
            "3"
        )
    }
    
    func testEndsWith() {
        try XCTAssertEqual(
            sut.endsWith(string: "1abc2"),
            "2"
        )
        try XCTAssertNil(
            sut.endsWith(string: "pqr3stu8vwx")
        )
        try XCTAssertEqual(
            sut.endsWith(string: "3stu8"),
            "8"
        )
    }
    
    func testFirstNumber() {
        try XCTAssertEqual(sut.firstNumber(in: "1abc2"), "1")
        try XCTAssertEqual(sut.firstNumber(in: "pqr3stu8vwx"), "3")
        try XCTAssertEqual(sut.firstNumber(in: "a1b2c3d4e5f"), "1")
        try XCTAssertEqual(sut.firstNumber(in: "treb7uchet"), "7")
    }
    
    func testLastNumber() {
        try XCTAssertEqual(sut.lastNumber(in: "1abc2"), "2")
        try XCTAssertEqual(sut.lastNumber(in: "pqr3stu8vwx"), "8")
        try XCTAssertEqual(sut.lastNumber(in: "a1b2c3d4e5f"), "5")
        try XCTAssertEqual(sut.lastNumber(in: "treb7uchet"), "7")
    }
    
    func testPartOne() throws {
        try XCTAssertEqual(sut.calculatePartOne(), 142)
    }
}

// MARK: - Part 2 Tests
extension Day1Tests {
    func testStartsWithPartTwo() {
        try XCTAssertNil(
            sut.startsWith(string: "two1nine")
        )
        try XCTAssertEqual(
            sut.startsWith(string: "two1nine", isPartTwo: true),
            "2"
        )
        
        try XCTAssertNil(
            sut.startsWith(string: "eightwothree")
        )
        try XCTAssertEqual(
            sut.startsWith(string: "eightwothree", isPartTwo: true),
            "8"
        )
        
        try XCTAssertNil(
            sut.startsWith(string: "abcone2threexyz")
        )
        try XCTAssertNil(
            sut.startsWith(string: "abcone2threexyz", isPartTwo: true)
        )
    }
    
    func testFirstNumberPartTwo() {
        try XCTAssertEqual(
            sut.firstNumber(in: "abcone2threexyz"),
            "2"
        )
        try XCTAssertEqual(
            sut.firstNumber(in: "abcone2threexyz", isPartTwo: true),
            "1"
        )
    }
    
    func testEndsWithPartTwo() {
        try XCTAssertNil(
            sut.endsWith(string: "two1nine")
        )
        try XCTAssertEqual(
            sut.endsWith(string: "two1nine", isPartTwo: true),
            "9"
        )
        
        try XCTAssertNil(
            sut.endsWith(string: "eightwothree")
        )
        try XCTAssertEqual(
            sut.endsWith(string: "eightwothree", isPartTwo: true),
            "3"
        )
        
        try XCTAssertNil(
            sut.endsWith(string: "abcone2threexyz")
        )
        try XCTAssertNil(
            sut.endsWith(string: "abcone2threexyz", isPartTwo: true)
        )
    }
    
    func testLastNumberPartTwo() {
        try XCTAssertEqual(
            sut.lastNumber(in: "abcone2threexyz"),
            "2"
        )
        try XCTAssertEqual(
            sut.lastNumber(in: "abcone2threexyz", isPartTwo: true),
            "3"
        )
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(sut2.calculatePartTwo(), 281)
    }
}
