import Foundation

try print("""
Day 9:
Sample Answer: \(solve(filename: "sample.input"))
Solution Answer: \(solve(filename: "solution.input"))

Extension Task:
Sample Answer: \(solveExtension(filename: "sample.input"))
Solution Answer: \(solveExtension(filename: "solution.input"))
""")

// MARK: - Parse input into data structure

func openFile(filename: String) throws -> String {
    let cwd = FileManager.default.currentDirectoryPath
    return try String(contentsOfFile: "\(cwd)/\(filename)", encoding: .utf8)
}

func generateGrid(input: String) -> [[Int]] {
    input.components(separatedBy: "\n")
        .filter { !$0.isEmpty }
        .map { $0.map(String.init).compactMap(Int.init) }
}

typealias Point = (x: Int, y: Int)

// MARK: - Miscellaneous Functions
extension Array where Element == [Int] {
    private func pointsSurrounding(x: Int, y: Int) -> [Point] {
        [
            x > 0 ? (x-1, y) : nil,
            x < count - 1 ? (x+1, y) : nil,
            y > 0 ? (x, y-1) : nil,
            y < self[x].count - 1 ? (x, y+1) : nil
        ].compactMap { $0 }
    }
    
    func findLowPoints() -> [Point] {
        let gridSize = (width: self[0].count, height: count)
        
        var lowPoints: [Point] = []
        for rowIndex in 0..<gridSize.height {
            for columnIndex in 0..<gridSize.width {
                if pointsSurrounding(x: rowIndex, y: columnIndex)
                    .map({ self[$0.x][$0.y] })
                    .allSatisfy({ $0 > self[rowIndex][columnIndex] }) {
                    lowPoints.append((x: rowIndex, y: columnIndex))
                }
            }
        }
        
        return lowPoints
    }
    
    func findBasin(around point: Point) -> [Point] {
        var points: [Point] = []
        var nextPoints: [Point] = [point]
        
        while !nextPoints.isEmpty {
            for point in nextPoints {
                if !points.contains(where: { $0.x == point.x && $0.y == point.y }) {
                    points.append(point)
                }
            }
            
            nextPoints = nextPoints.flatMap(surroundingBasinPoints)
        }
        
        return points
    }
    
    
    private func surroundingBasinPoints(around point: Point) -> [Point] {
        pointsSurrounding(x: point.x, y: point.y)
            .map { (point: $0, value: self[$0.x][$0.y]) }
            .filter { $0.value != 9 }
            .filter { $0.value > self[point.x][point.y] }
            .map { $0.point }
    }
}

// MARK: - Solve Challenge 1

func solve(filename: String) throws -> Int {
    let input = try openFile(filename: filename)
    let grid = generateGrid(input: input)
    let lowPointValues = grid.findLowPoints().map { grid[$0.x][$0.y] }
    return lowPointValues.map { $0 + 1 }.reduce(0, +)
}

// MARK: - Solve Challenge 2

func solveExtension(filename: String) throws -> Int {
    let input = try openFile(filename: filename)
    let grid = generateGrid(input: input)
    return grid
        .findLowPoints()
        .map { grid.findBasin(around: $0) }
        .map { $0.count }
        .sorted()
        .suffix(3)
        .reduce(1, *)
}
