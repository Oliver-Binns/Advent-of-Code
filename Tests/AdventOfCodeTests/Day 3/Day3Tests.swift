import XCTest
@testable import AdventOfCode

final class Day3Tests: XCTestCase, SolutionTest {
    typealias SUT = Day3
    
    func testPartOne() throws {
        try XCTAssertEqual(sut.calculatePartOne(), 157)
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(sut.calculatePartTwo(), 70)
    }
}

extension Day3Tests {
    func testInitialisation() throws {
        try XCTAssertEqual(sut.rucksacks.count, 6)
        try XCTAssertEqual(sut.rucksacks, [
            "vJrwpWtwJgWrhcsFMMfFFhFp",
            "jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL",
            "PmmdzqPrVvPwwTWBwg",
            "wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn",
            "ttgJtRGJQctTZtZT",
            "CrZsJsPPZsGzwwsLwLmpwMDw"
        ])
    }
    
    func testCompartments() throws {
        try XCTAssertEqual(sut.compartments(in: "vJrwpWtwJgWrhcsFMMfFFhFp"),
                           [
                            ["v", "J", "r", "w", "p", "W", "t", "J", "g"],
                            ["h", "c", "s", "F", "M", "f", "h", "p"]
                           ])
    }
    
    func testIntersection() throws {
        try XCTAssertEqual(sut.intersections,
                           ["p", "L", "P", "v", "t", "s"])
    }
    
    func testPriority() {
        try XCTAssertEqual(sut.priority(of: "a"), 1)
        try XCTAssertEqual(sut.priority(of: "b"), 2)
        
        try XCTAssertEqual(sut.priority(of: "z"), 26)
        
        try XCTAssertEqual(sut.priority(of: "A"), 27)
        try XCTAssertEqual(sut.priority(of: "B"), 28)
        
        try XCTAssertEqual(sut.priority(of: "Z"), 52)
    }
    
    func testGroups() {
        let rucksacks = ["aab", "bbc", "ccd", "dde", "eef", "ffg"]
        try XCTAssertEqual(sut.groups(rucksacks: rucksacks), [
            [["a", "b"], ["b", "c"], ["c", "d"]],
            [["d", "e"], ["e", "f"], ["f", "g"]]
        ])
    }
}
