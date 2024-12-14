struct Day14: Solution, Processor {
    static let day = 14

    let robots: [RobotMovement]
    var gridSize: (x: Int, y: Int) = (x: 101, y: 103)

    var quadrants: [Quadrant] {
        let centerX = gridSize.x / 2
        let centerY = gridSize.y / 2

        return [
            Quadrant(x: 0..<centerX, y: 0..<centerY),
            Quadrant(x: 0..<centerX, y: centerY+1..<gridSize.y+1),
            Quadrant(x: centerX+1..<gridSize.x+1, y: 0..<centerY),
            Quadrant(x: centerX+1..<gridSize.x+1, y: centerY+1..<gridSize.y+1)
        ]
    }

    init(input: String) {
        robots = input
            .components(separatedBy: .newlines)
            .filter { !$0.isEmpty }
            .compactMap(RobotMovement.init)
    }

    func calculatePartOne() -> Int {
        let finalPositions = newPositions(after: 100)
        return quadrants.map { quadrant in
            finalPositions
                .filter(quadrant.contains)
                .count
        }.reduce(1, *)
    }

    func calculatePartTwo() async -> Int {
       await withTaskGroup(
            of: Int?.self,
            returning: Int.self
        ) { taskGroup in
            for i in (0...9000).chunks(ofCount: 30) {
                let processor = BackgroundProcessor(
                    gridSize: gridSize,
                    robots: robots
                )
                taskGroup.addTask {
                    await processor.process(ranges: i)
                }
            }

            for await result in taskGroup {
                guard let result else { continue }
                return result
            }
            return 0
        }
    }

    struct Quadrant: Equatable {
        let x: Range<Int>
        let y: Range<Int>

        func contains(_ point: Point) -> Bool {
            x.contains(point.x) && y.contains(point.y)
        }
    }

    func containsRow(positions: [Point]) -> Bool {
        let string = stringify(positions: positions)
        let grid = Grid(string: string)
        let ones = grid.findPositions(of: "1")

        var searched: Set<Point> = []

        func iterate(point: Point) -> Int {
            guard !searched.contains(point),
                  grid[point] == "1" else {
                searched.insert(point)
                return 0
            }

            searched.insert(point)

            return 1 + [Direction.north, .east, .south, .west]
                .map { point.move(in: $0) }
                .filter(grid.isWithinBounds)
                .map(iterate)
                .reduce(0, +)

        }

        for one in ones {
            if iterate(point: one) >= 50 {
                return true
            }
        }

        return false
    }
}

protocol Processor {
    var gridSize: (x: Int, y: Int) { get }
    var robots: [RobotMovement] { get }
}

extension Processor {
    func newPositions(after seconds: Int) -> [Point] {
        robots.map {
            newPosition(ofRobot: $0, after: seconds)
        }
    }

    func newPosition(
        ofRobot robot: RobotMovement,
        after seconds: Int
    ) -> Point {
        let x = (robot.position.x + robot.velocity.x * seconds)
            %+ gridSize.x
        let y = (robot.position.y + robot.velocity.y * seconds)
            %+ gridSize.y
        return Point(x: x, y: y)
    }

    func stringify(positions: [Point]) -> String {
        (0..<gridSize.y).map { y in
            (0..<gridSize.x).map { x in
                let robots = positions
                    .count(where: { $0.x == x && $0.y == y })

                if robots > 0 {
                    return robots.description
                } else {
                    return "."
                }
            }.joined()
        }.joined(separator: "\n")
    }
}

actor BackgroundProcessor: Processor {
    let gridSize: (x: Int, y: Int)
    let robots: [RobotMovement]

    init(
        gridSize: (x: Int, y: Int),
        robots: [RobotMovement]
    ) {
        self.gridSize = gridSize
        self.robots = robots
    }

    func process(ranges: Slice<ClosedRange<Int>>) -> Int? {
        ranges
            .first {
                let positions = newPositions(after: $0)
                return containsRow(positions: positions)
            }
    }

    func containsRow(positions: [Point]) -> Bool {
        let string = stringify(positions: positions)
        let grid = Grid(string: string)
        let ones = grid.findPositions(of: "1")

        var searched: Set<Point> = []

        func iterate(point: Point) -> Int {
            guard !searched.contains(point),
                  grid[point] == "1" else {
                searched.insert(point)
                return 0
            }

            searched.insert(point)

            return 1 + [Direction.north, .east, .south, .west]
                .map { point.move(in: $0) }
                .filter(grid.isWithinBounds)
                .map(iterate)
                .reduce(0, +)

        }

        for one in ones {
            if iterate(point: one) >= 50 {
                return true
            }
        }

        return false
    }
}

infix operator %+ : MultiplicationPrecedence
extension Int {
    static func %+ (left: Int, right: Int) -> Int {
        let value = left % right
        guard value >= 0 else {
            return right + value
        }
        return value
    }
}

struct RobotMovement: Equatable {
    let position: Point
    let velocity: Point
}

extension RobotMovement {
    init(input: String) {
        let components = input
            .filter { !($0.isLetter || $0 == "=") }
            .components(separatedBy: .whitespaces)

        position = Point(input: String(components[0]))
        velocity = Point(input: String(components[1]))
    }
}

extension Point {
    init(input: String) {
        let components = input
            .components(separatedBy: ",")
            .compactMap(Int.init)

        self.x = components[0]
        self.y = components[1]
    }
}
