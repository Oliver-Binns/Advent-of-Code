enum LoopError: Error {
    case infiniteLoop
}

struct Day6: Solution {
    static let day = 6

    let grid: Grid<Character>

    init(input: String) {
        grid = Grid(string: input)
    }

    func calculatePartOne() -> Int {
        do {
            return try calculateVisitedPositions(grid: self.grid)
                .reduce(Set<Point>()) {
                    $0.union([$1.point])
                }
                .count
        } catch {
            fatalError("infinite loop should not occur with this grid")
        }
    }
    
    func calculatePartTwo() -> Int {
        // test placing a new obstacle in front of each _visited_ position
        // only these will cause a change in direction
        let visitedPositions = try! calculateVisitedPositions(grid: self.grid)
        let obstaclesPositions = visitedPositions
            .map {
                $0.point.move(in: $0.direction)
            }
            .reduce(Set<Point>()) { $0.union([$1]) }
            .filter(grid.isWithinBounds)
            .filter {
                // cannot place on start position
                grid[$0] != "^"
            }

        return obstaclesPositions.filter {
            do {
                let grid = amendGrid(withNewObstacleAt: $0)
                _ = try calculateVisitedPositions(grid: grid)
                return false
            } catch {
                return true
            }
        }
        .count
    }

    func calculateVisitedPositions(grid: Grid<Character>) throws -> Set<Visit> {
        var visitedPositions: Set<Visit> = []
        var guardPosition = grid.findPositions(of: "^")[0]
        var direction = Direction.north

        func trackVisit() throws {
            let visit = Visit(
                point: guardPosition,
                direction: direction
            )

            if visitedPositions.contains(visit) {
                throw LoopError.infiniteLoop
            } else {
                visitedPositions.insert(visit)
            }
        }

        while grid.isWithinBounds(point: guardPosition) {
            if grid[guardPosition] == "#" {
                // return to previous position
                guardPosition = guardPosition.move(
                    in: direction.rotateClockwise().rotateClockwise()
                )
                // rotate direction
                direction = direction.rotateClockwise()

                try trackVisit()
            } else {
                try trackVisit()
            }

            guardPosition = guardPosition.move(in: direction)
        }

        return visitedPositions
    }

    func amendGrid(
        withNewObstacleAt position: Point,
        character: Character = "#"
    ) -> Grid<Character> {
        var values = self.grid.values
        values[position.y][position.x] = character
        return Grid(values: values)
    }
}

struct Visit: Hashable {
    let point: Point
    let direction: Direction
}
