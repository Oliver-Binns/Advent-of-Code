import Foundation

try print("""
Day 4:
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

func buildBoard(input: [String]) -> Board {
    Board(data: input.map {
        $0.components(separatedBy: " ").compactMap(Int.init)
    })
}

func buildBoards(input: [String]) -> [Board] {
    input
        .split(whereSeparator: { $0 == "" })
        .map(Array.init)
        .map(buildBoard)
}

func buildGame(input: String) -> Game {
    let lines = input.components(separatedBy: "\n")
    
    let calledNumbers = lines[0]
        .components(separatedBy: ",")
        .compactMap(Int.init)
    
    let boards = buildBoards(input: Array(lines.suffix(from: 1)))

    return Game(calledNumbers: calledNumbers, boards: boards)
}

// MARK: - Data Structure

struct Game {
    private(set) var calledNumbers: [Int]
    private(set) var boards: [Board]
    
    var isFinished: Bool {
        calledNumbers.isEmpty
    }
    
    mutating func playRound() -> Int? {
        for i in 0..<boards.count {
            guard !boards[i].hasWon else { continue }
            if let score = boards[i].playRound(calledNumber: calledNumbers[0]) {
                return score
            }
        }
        calledNumbers = Array(calledNumbers.suffix(from: 1))
        return nil
    }
}

struct Board {
    private(set) var data: [[Int?]]
    
    var sumOfRemainingNumbers: Int {
        data.reduce(0) { sum, newValue in
            sum + newValue
                .compactMap { $0 }
                .reduce(0, +)
        }
    }
    
    var hasWon: Bool {
        let isRowEmpty = data.map { $0.compactMap { $0 } }.contains { $0.isEmpty }
        let columnCount = data[0].count
        let isColumnEmpty = (0..<columnCount).map { columnIndex in
            data.map { $0[columnIndex] }
        }.map { $0.compactMap { $0 } }.contains { $0.isEmpty }
        return isRowEmpty || isColumnEmpty
    }
    
    mutating func playRound(calledNumber: Int) -> Int? {
        data = data.map {
            $0.map {
                guard $0 != calledNumber else {
                    return nil
                }
                return $0
            }
        }
        
        guard hasWon else { return nil }
        return calledNumber * sumOfRemainingNumbers
        
    }
}

// MARK: - Solve Challenge 1

func solve(filename: String) throws -> Int {
    let input = try openFile(filename: filename)
    var game = buildGame(input: input)
    while !game.isFinished {
        if let score = game.playRound() {
            return score
        }
    }
    return -1
}

// MARK: - Solve Challenge 2

func solveExtension(filename: String) throws -> Int {
    let input = try openFile(filename: filename)
    var game = buildGame(input: input)
    
    var scores: [Int] = []
    while !game.isFinished {
        if let score = game.playRound() {
            scores.append(score)
        }
    }
    return scores.last ?? -1
}
