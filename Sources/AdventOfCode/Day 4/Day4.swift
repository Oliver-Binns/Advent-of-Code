struct Day4: Solution {
    static let day = 4

    let grid: Grid<Character>

    init(input: String) {
        grid = Grid(values: input
            .components(separatedBy: .newlines)
            .map {
                $0.reduce([Character]()) {
                    $0 + [$1]
                }
            }
            .filter { !$0.isEmpty }
        )
    }

    func calculatePartOne() -> Int {
        grid.countOccurences(of: "XMAS")
    }
    
    func calculatePartTwo() -> Int {
        grid.countX(
            origin: "A",
            value1: "M",
            value2: "S"
        )
    }
}

