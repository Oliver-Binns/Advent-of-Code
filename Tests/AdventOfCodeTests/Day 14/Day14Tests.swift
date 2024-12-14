import XCTest
@testable import AdventOfCode

final class Day14Tests: XCTestCase, SolutionTest {
    typealias SUT = Day14
    
    func testPartOne() throws {
        var sut = try self.sut
        sut.gridSize = (x: 11, y: 7)

        XCTAssertEqual(sut.calculatePartOne(), 12)
    }
    
    func testPartTwo() async throws {
        let part2 = try await sut.calculatePartTwo()
        XCTAssertEqual(part2, 0)
    }
}

extension Day14Tests {
    func testParsing() throws {
        XCTAssertEqual(try sut.robots, [
            RobotMovement(
                position: Point(x: 0, y: 4),
                velocity: Point(x: 3, y: -3)
            ),
            RobotMovement(
                position: Point(x: 6, y: 3),
                velocity: Point(x: -1, y: -3)
            ),
            RobotMovement(
                position: Point(x: 10, y: 3),
                velocity: Point(x: -1, y: 2)
            ),
            RobotMovement(
                position: Point(x: 2, y: 0),
                velocity: Point(x: 2, y: -1)
            ),
            RobotMovement(
                position: Point(x: 0, y: 0),
                velocity: Point(x: 1, y: 3)
            ),
            RobotMovement(
                position: Point(x: 3, y: 0),
                velocity: Point(x: -2, y: -2)
            ),
            RobotMovement(
                position: Point(x: 7, y: 6),
                velocity: Point(x: -1, y: -3)
            ),
            RobotMovement(
                position: Point(x: 3, y: 0),
                velocity: Point(x: -1, y: -2)
            ),
            RobotMovement(
                position: Point(x: 9, y: 3),
                velocity: Point(x: 2, y: 3)
            ),
            RobotMovement(
                position: Point(x: 7, y: 3),
                velocity: Point(x: -1, y: 2)
            ),
            RobotMovement(
                position: Point(x: 2, y: 4),
                velocity: Point(x: 2, y: -3)
            ),
            RobotMovement(
                position: Point(x: 9, y: 5),
                velocity: Point(x: -3, y: -3)
            )])
    }

    func testCalculateNewPositions() throws {
        var sut = try self.sut
        sut.gridSize = (x: 11, y: 7)

        let robot = RobotMovement(
            position: Point(x: 2, y: 4),
            velocity: Point(x: 2, y: -3)
        )

        XCTAssertEqual(
            sut.newPosition(ofRobot: robot, after: 0),
            Point(x: 2, y: 4)
        )
        XCTAssertEqual(
            sut.newPosition(ofRobot: robot, after: 1),
            Point(x: 4, y: 1)
        )
        XCTAssertEqual(
            sut.newPosition(ofRobot: robot, after: 5),
            Point(x: 1, y: 3)
        )
    }

    func testQuadrants() throws {
        var sut = try self.sut
        sut.gridSize = (x: 11, y: 7)

        XCTAssertEqual(
            sut.quadrants,
            [
                .init(x: 0..<5, y: 0..<3),
                .init(x: 0..<5, y: 4..<8),
                .init(x: 6..<12, y: 0..<3),
                .init(x: 6..<12, y: 4..<8)
            ]
        )
    }
}
