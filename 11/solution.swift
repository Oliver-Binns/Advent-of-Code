import Foundation

try print("""
Day 10:
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

func parseLines(input: String) -> [[Int]] {
    input
        .components(separatedBy: "\n")
        .filter { !$0.isEmpty }
        .map { $0.map(String.init).compactMap(Int.init) }
}

// MARK: - Array Extensions for Grid

struct Point: Hashable {
    let x: Int
    let y: Int
}

typealias GridSize = (width: Int, height: Int) 

extension Array where Element == [Int] {
    private func adjacentCells(x: Int, y: Int) -> [Point] {
        let canGoLeft = x > 0
        let canGoRight = x < count - 1
        let canGoUp = y > 0
        let canGoDown = y < self[x].count - 1

        return [
            canGoLeft ? (x-1, y) : nil,
            canGoLeft && canGoUp ? (x-1, y-1) : nil,
            canGoUp ? (x, y-1) : nil,
            canGoUp && canGoRight ? (x+1, y-1) : nil,
            canGoRight ? (x+1, y) : nil,
            canGoRight && canGoDown ? (x+1, y+1) : nil,
            canGoDown ? (x, y+1) : nil,
            canGoDown && canGoLeft ? (x-1, y+1) : nil
        ].compactMap { $0 }.map { Point(x: $0.0, y: $0.1) }
    }

    private mutating func incrementAllOctopuses(gridSize: GridSize) {
        for rowIndex in 0..<gridSize.width {
            for columnIndex in 0..<gridSize.width {
                self[rowIndex][columnIndex] += 1
            }
        }
    }

    private mutating func incrementOctopuses(gridSize: GridSize) {
        // First Increment All The Octopuses By One
        incrementAllOctopuses(gridSize: gridSize)

        var octopusFlashes: Set<Point> = []
        var adjacentCells: [Point] = []

	// If There Are Octopuses Greater Than Ten Add These To Our Count
	for rowIndex in 0..<gridSize.width {
            for columnIndex in 0..<gridSize.width {
                if self[rowIndex][columnIndex] > 9 {
                    octopusFlashes.insert(.init(x: rowIndex, y: columnIndex))
                    adjacentCells.append(contentsOf: self.adjacentCells(x: rowIndex, y: columnIndex))
                }
            } 
        }
        
        while !adjacentCells.isEmpty {
            let cell = adjacentCells.removeFirst()
            self[cell.x][cell.y] += 1
            
            // cells can only flash once
            if !octopusFlashes.contains(cell) && self[cell.x][cell.y] > 9 {
                octopusFlashes.insert(cell)
                adjacentCells.append(contentsOf: self.adjacentCells(x: cell.x, y: cell.y)) 
            }
        }
    }

    private mutating func resetOctopuses(gridSize: GridSize) -> Int {
        var flashCount = 0 
        for rowIndex in 0..<gridSize.width {
            for columnIndex in 0..<gridSize.width {
                if self[rowIndex][columnIndex] > 9 {
                    self[rowIndex][columnIndex] = 0
                    flashCount += 1 
                }
            } 
        }
        return flashCount 
    } 

    mutating func nextStep() -> Int {
        let gridSize = (width: self[0].count, height: count)
        incrementOctopuses(gridSize: gridSize)        
        return resetOctopuses(gridSize: gridSize)
    }
}

// MARK: - Solve Challenge 1

func solve(filename: String) throws -> Int {
    let input = try openFile(filename: filename)
    var grid = parseLines(input: input)
    var flashCount = 0

    for _ in 0..<100 {
        flashCount += grid.nextStep()
    }  
    return flashCount
}

// MARK: - Solve Challenge 2

func solveExtension(filename: String) throws -> Int {
    let input = try openFile(filename: filename)
    var grid = parseLines(input: input)
    var step = 1
    while grid.nextStep() != 100 {
        step += 1
    }  
    return step
}