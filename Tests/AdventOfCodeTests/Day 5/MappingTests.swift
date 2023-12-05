import XCTest
@testable import AdventOfCode

final class MappingTests: XCTestCase {
    let sut = Mapping(sourceStart: 50, destinationStart: 98, length: 2)
    
    func testInitialisation() {
        
        XCTAssertEqual(sut.source.lowerBound, 50)
        XCTAssertEqual(sut.source.upperBound, 52)
        
        XCTAssertEqual(sut.destination.lowerBound, 98)
        XCTAssertEqual(sut.destination.upperBound, 100)
    }
    
    func testMappingContains() {
        XCTAssertFalse(sut.contains(item: 47))
        XCTAssertFalse(sut.contains(item: 48))
        XCTAssertFalse(sut.contains(item: 49))
        XCTAssertTrue(sut.contains(item: 50))
        XCTAssertTrue(sut.contains(item: 51))
        XCTAssertFalse(sut.contains(item: 52))
        XCTAssertFalse(sut.contains(item: 53))
    }
    
    func testMappingMapItem() {
        XCTAssertEqual(sut.map(item: 50), 98)
        XCTAssertEqual(sut.map(item: 51), 99)
    }
    
    func testMappingRangeSubset() {
        let (lower, mid, upper) = sut.map(range: 40..<60)
        XCTAssertEqual(lower, 40..<50)
        XCTAssertEqual(mid, 98..<100)
        XCTAssertEqual(upper, 52..<60)
    }
    
    func testMappingRangeWithOverlapAtBottom() {
        let (lower, mid, upper) = sut.map(range: 40..<51)
        XCTAssertEqual(lower, 40..<50)
        XCTAssertEqual(mid, 98..<99)
        XCTAssertNil(upper)
    }
    
    func testMappingRangeWithOverlapAtTop() {
        let (lower, mid, upper) = sut.map(range: 51..<60)
        XCTAssertNil(lower)
        XCTAssertEqual(mid, 99..<100)
        XCTAssertEqual(upper, 52..<60)
    }
}
