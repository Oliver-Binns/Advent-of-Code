import Foundation

try print("""
Day 15:
Sample Answer: \(solve(filename: "sample.input"))
Solution Answer: \(solve(filename: "solution.input"))

Extension Task:
Sample Answer: \(solveExtension(filename: "sample.input"))
Solution Answer: \(solveExtension(filename: "solution.input"))
""")

// MARK: - Parse input into data structure

func  openFile(filename: String) throws -> String {
    let cwd = FileManager.default.currentDirectoryPath
    return try String(contentsOfFile: "\(cwd)/\(filename)", encoding: .utf8)
}

func generateGrid(input: String) -> [[Int]]{
    input.components(separatedBy: "\n")
        .filter { !$0.isEmpty }
        .map { $0.map(String.init).compactMap(Int.init) }
}

func calculateRiskGrid(grid: [[Int]]) -> [[Int]] {
    let gridSize = (width: grid[0].count, height: grid.count)
    var riskGrid = Array(repeating: Array(repeating: 0, count: gridSize.width),
                         count: gridSize.height)
    
    for section in (0..<gridSize.height * 2) {
        for offset in (0...section).map({ (section - $0, $0) }) {
            guard offset.0 < gridSize.width,
                  offset.1 < gridSize.height else { continue }
            
            let xPosition = gridSize.width - offset.0 - 1
            let yPosition = gridSize.height - offset.1 - 1
            
            let smallestAdjacentRisk = [
                yPosition + 1 < gridSize.height ? riskGrid[yPosition+1][xPosition] : nil,
                xPosition + 1 < gridSize.width ? riskGrid[yPosition][xPosition + 1] : nil
            ].compactMap { $0 }.min() ?? 0
            
            let cellRisk = grid[yPosition][xPosition]
            let totalRisk = cellRisk + smallestAdjacentRisk
            riskGrid[yPosition][xPosition] = totalRisk
        }
    }
    
    return riskGrid
}

func expandGrid(_ grid: [[Int]]) -> [[Int]] {
    let gridSize = (width: grid[0].count, height: grid.count)
    let newGridSize = (width: gridSize.width * 5, height: gridSize.height * 5)
    var expandedGrid: [[Int]] = Array(repeating: Array(repeating: 0, count: newGridSize.width),
                                      count: newGridSize.height)
    
    for x in 0..<newGridSize.width {
        for y in 0..<newGridSize.height {
            let originalX = x % gridSize.width
            let originalY = y % gridSize.height
            
            let gridOffsetX = x / gridSize.width
            let gridOffsetY = y / gridSize.height
            
            let originalValue = grid[originalY][originalX]
            
            let transformedValue = (originalValue + gridOffsetX + gridOffsetY) % 9
            expandedGrid[y][x] = transformedValue > 0 ? transformedValue : 9
        }
    }
    
    return expandedGrid
}

// MARK: - Solve Challenge 1

func solve(filename: String) throws -> Int {
    let input = try openFile(filename: filename)
    let grid = generateGrid(input: input)
    return calculateRiskGrid(grid: grid)[0][0] - grid[0][0]
}

// MARK: - Solve Challenge 2

func solveExtension(filename: String) throws -> Int {
    let input = try openFile(filename: filename)
    let grid = generateGrid(input: input)
    let expandedGrid = expandGrid(grid)
    
    var riskGrid = calculateRiskGrid(grid: expandedGrid)
    let gridSize = (width: riskGrid[0].count, height: riskGrid.count)
    
    // Iterate to find alternative routes:
    for yPosition in (0..<gridSize.height).reversed() {
        for xPosition in (0..<gridSize.width).reversed() {
            let smallestAdjacentRisk = [
                yPosition + 1 < gridSize.height ? riskGrid[yPosition+1][xPosition] : nil,
                xPosition + 1 < gridSize.width ? riskGrid[yPosition][xPosition + 1] : nil,
                yPosition - 1 >= 0 ? riskGrid[yPosition-1][xPosition] : nil,
                xPosition - 1 >= 0 ? riskGrid[yPosition][xPosition-1] : nil
            ].compactMap { $0 }.min() ?? 0
            
            let positionRisk = expandedGrid[yPosition][xPosition]
            if (smallestAdjacentRisk + positionRisk) < riskGrid[yPosition][xPosition] {
                riskGrid[yPosition][xPosition] = smallestAdjacentRisk + positionRisk
            }
        }
    }
    
    return riskGrid[0][0] - grid[0][0]
}
