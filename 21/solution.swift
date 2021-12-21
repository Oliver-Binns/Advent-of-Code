import Foundation

try print("""
Day 21:
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
        .trimmingCharacters(in: .whitespacesAndNewlines)
}

func parseStartingPositions(input: String) -> [Int] {
    input
        .components(separatedBy: "\n")
        .compactMap { String($0).last }
        .map(String.init).compactMap(Int.init)
}

// MARK: Game Logic

struct DeterministicDice {
    var currentRoll = 0

    mutating private func roll() -> Int {
        defer {
            currentRoll += 1
        }
        return (currentRoll % 100) + 1
    }

    mutating func rollThreeTimes() -> Int {
        (0..<3).map { _ in roll() }.reduce(0, +)
    }
}

struct DiracDice {
    func roll() -> ClosedRange<Int> {
        1...3
    }

    func rollThreeTimes() -> [Int] {
        roll().flatMap { one in
            roll().flatMap { two in
                roll().map { three in
                    one + two + three
                }
            }
        }
    }
}

struct Player: Hashable {
    let position: Int
    let score: Int

    func didRoll(_ roll: Int) -> Player {
        let newPosition =  (position + roll - 1) % 10 + 1
        return Player(position: newPosition,
                      score: score + newPosition)
    }
}
extension Player: CustomStringConvertible {
    var description: String {
        "\(position) (\(score))"
    }
}


// MARK: Challenge 1 Solution

func solve(filename: String, iterations: Int = 2) throws -> Int {
    let input = try openFile(filename: filename)

    var players = parseStartingPositions(input: input)
        .map { Player(position: $0, score: 0) }

    var dice = DeterministicDice()

    while players.allSatisfy({ $0.score < 1000 }) {
        for index in 0..<players.count where players.allSatisfy({ $0.score < 1000 }) {
            let roll = dice.rollThreeTimes()
            players[index] = players[index].didRoll(roll)
        }
    }

    return dice.currentRoll * (players.map { $0.score }.first(where: { $0 < 1000 }) ?? 0)
}

// MARK: Challenge 2 Solution

func solveExtension(filename: String) throws -> Int {
    let input = try openFile(filename: filename)

    let players = parseStartingPositions(input: input)
        .map { Player(position: $0, score: 0) }

    let dice = DiracDice()
    var states = [GameState(players: players): 1]

    while states.contains(where: { !$0.key.isComplete }) {
        // advance each of the states:
        var newStates: [GameState: Int] = [:]

        for (state, count) in states {
            guard !state.isComplete else {
                newStates[state, default: 0] += count
                continue;
            }

            for playerOne in dice.rollThreeTimes()
                .map(state.players[0].didRoll) {

                guard playerOne.score < 21 else {
                    let state = GameState(players: [playerOne, state.players[1]])
                    newStates[state, default: 0] += count
                    continue
                }

                for playerTwo in dice.rollThreeTimes()
                    .map(state.players[1].didRoll) {
                    let state = GameState(players: [playerOne, playerTwo])
                    newStates[state, default: 0] += count
                }
            }
        }

        states = newStates
    }


    let player1Wins = states.filter { $0.key.players[0].score >= 21 }.map { $0.value }.reduce(0, +)
    let player2Wins = states.filter { $0.key.players[1].score >= 21 }.map { $0.value }.reduce(0, +)

    return [player1Wins, player2Wins].max() ?? 0
}

struct GameState: Hashable {
    let players: [Player]

    var isComplete: Bool {
        players.contains(where: { $0.score >= 21 })
    }
}
extension GameState: CustomStringConvertible {
    var description: String {
        "[\(players[0]), \(players[1])]"
    }
}
