import Foundation

try print("""
Day 25:
Sample Answer: \(solve(filename: "sample.input"))
Solution Answer: \(solve(filename: "solution.input"))

Extension Task: N/A
""")

// MARK: - Parse input into data structure

func openFile(filename: String) throws -> String {
    let cwd = FileManager.default.currentDirectoryPath
    return try String(contentsOfFile: "\(cwd)/\(filename)", encoding: .utf8)
        .trimmingCharacters(in: .whitespacesAndNewlines)
}

func parseInput(_ input: String) -> [[Location]] {
    input
        .components(separatedBy: "\n")
        .map(parseLine)
}

func parseLine(_ line: String) -> [Location] {
    line.compactMap(Location.init)
}

// MARK: - Data Structure

enum Location: Character, Equatable {
    case empty = "."
    case east = ">"
    case south = "v"
}

extension Array where Element == [Location] {
    func nextStep() -> Self {
        moveEast().moveSouth()
    }

    private func moveEast() -> Self {
        var next = self
        for y in 0..<count {
            let rowLength = self[y].count
            for x in 0..<rowLength {
                let nextIndex = (x + 1) % rowLength
                if self[y][x] == .east,
                   self[y][nextIndex] == .empty {
                    next[y][x] = .empty
                    next[y][nextIndex] = .east
                }
            }
        }
        return next
    }

    private func moveSouth() -> Self {
        var next = self
        let columnLength = count
        for y in 0..<columnLength {
            let nextIndex = (y + 1) % columnLength
            for x in 0..<self[y].count {
                if self[y][x] == .south,
                   self[nextIndex][x] == .empty {
                    next[y][x] = .empty
                    next[nextIndex][x] = .south
                }
            }
        }
        return next
    }
}

// MARK: - Challenge 1 Solution
func solve(filename: String) throws -> Int {
    let input = try openFile(filename: filename)

    var grid = parseInput(input)
    var nextStep = grid.nextStep()

    //for line in nextStep {
    //    print(String(line.map { $0.rawValue }))
    //}

    var move = 1
    while grid != nextStep {
        move += 1
        grid = nextStep
        nextStep = grid.nextStep()
    }

    return move
}
// MARK: - Challenge 2 Solution

func solveExtension(filename: String) throws -> String {
    "0"
}
