struct Day2: Solution {
    static let day = 2
    
    let games: [Game]
    private let totalCubes = [Cube.red: 12, .green: 13, .blue: 14]
    
    init(input: String) {
        games = input
            .components(separatedBy: .newlines)
            .filter { !$0.isEmpty }
            .map(Game.init)
    }

    func calculatePartOne() -> Int {
        games
            .filter { $0.isPossible(with: totalCubes) }
            .map(\.id)
            .reduce(0, +)
    }
    
    func calculatePartTwo() -> Int {
        games
            .map(\.minCubes)
            .map(\.power)
            .reduce(0, +)
    }
}
