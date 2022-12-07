import XCTest
@testable import AdventOfCode

final class Day7Tests: XCTestCase, SolutionTest {
    typealias SUT = Day7
    
    func testPartOne() throws {
        try XCTAssertEqual(sut.calculatePartOne(), 95437)
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(sut.calculatePartTwo(), 24933642)
    }
}

extension Day7Tests {
    func testCalculateSize() throws {
        try XCTAssertEqual(sut.state.size, 48381165)
    }
    
    func testSubdirectories() throws {
        let subdirectories = try sut.state.subdirectories.sorted { $0.name < $1.name}
        XCTAssertEqual(subdirectories.count, 4)
        
        XCTAssertEqual(subdirectories[0].name, "/")
        XCTAssertEqual(subdirectories[0].value, 48381165)
        
        XCTAssertEqual(subdirectories[1].name, "a")
        XCTAssertEqual(subdirectories[1].value, 94853)
        
        XCTAssertEqual(subdirectories[2].name, "d")
        XCTAssertEqual(subdirectories[2].value, 24933642)
        
        XCTAssertEqual(subdirectories[3].name, "e")
        XCTAssertEqual(subdirectories[3].value, 584)
        
    }
    
    func testIdenticalNames() {
        let subdirectories = Folder(name: "ab",
                                    folders: [
                                        "ab" : Folder(name: "ab", files: [.init(name: "test", size: 23)])
                                    ],
                                    files: [
                                        .init(name: "ab", size: 23)
                                    ]).subdirectories
        
        XCTAssertEqual(subdirectories.count, 2)
        
        XCTAssertEqual(subdirectories[0].name, "ab")
        XCTAssertEqual(subdirectories[0].value, 46)
        
        XCTAssertEqual(subdirectories[1].name, "ab")
        XCTAssertEqual(subdirectories[1].value, 23)
    }
}
