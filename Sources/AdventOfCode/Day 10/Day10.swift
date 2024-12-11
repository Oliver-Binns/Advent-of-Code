struct Day10: Solution {
    static let day = 10
    
    let grid: Grid<Int>
    
    init(input: String) {
        grid = Grid(
            string: input,
            mapping: { Int(String($0)) }
        )
    }
    
    func calculatePartOne() -> Int {
        grid
            .findPositions(of: 0)
            .map(findHighpointsReachable(from:))
            .map(Set.init) // unique points only
            .map(\.count)
            .reduce(0, +)
    }
    
    func calculatePartTwo() -> Int {
        grid
            .findPositions(of: 0)
            .map(findHighpointsReachable(from:))
            .map(\.count)
            .reduce(0, +)
    }
    
    func findHighpointsReachable(from point: Point) -> [Point] {
        guard grid[point] < 9 else {
            return [point]
        }
        
        return point.hikingSteps
            .filter(grid.isWithinBounds(point:))
            .filter { newPoint in
                grid[newPoint] == grid[point] + 1
            }
            .flatMap(findHighpointsReachable(from:))
    }
}

fileprivate extension Point {
    var hikingSteps: [Point] {
        [Direction.north, .east, .south, .west]
            .map { move(in: $0) }
    }
}
