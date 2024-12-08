import Algorithms

struct Day8: Solution {
    static let day = 8

    let grid: Grid<Character>

    var antennaLocations: [Character: Set<Point>] {
        grid.values.enumerated()
            .reduce(into: [:]) { partialResult, row in
                row.element
                    .enumerated()
                    .forEach { x, cell in
                        guard cell != "." else { return }
                        partialResult[cell, default: []]
                            .insert(Point(x: x, y: row.offset))
                    }
            }
    }

    func findAntinodes(usingUpdatedModel: Bool = false) -> Set<Point> {
        antennaLocations.map { _, points -> Set<Point> in
            Set(
                points
                .permutations(ofCount: 2)
                .map { ($0[0], $0[1], usingUpdatedModel) }
                .flatMap(calculateAntinodes)
            )

        }
        .reduce(Set()) { $0.union($1) }
    }

    func calculateAntinodes(
        between a: Point,
        and b: Point,
        usingUpdatedModel: Bool = false
    ) -> [Point] {
        let difference = (x: b.x - a.x, y: b.y - a.y)

        var index = 0
        var points = usingUpdatedModel ? [a] : []

        let nextPoint = { () -> Point? in
            index += 1
            return Point(
                x: a.x - difference.x * index,
                y: a.y - difference.y * index
            )
        }

        while let point = nextPoint(),
              grid.isWithinBounds(point: point) {
            points.append(point)

            guard usingUpdatedModel else {
                break
            }
        }

        return points
    }

    init(input: String) {
        grid = Grid(string: input)
    }
    
    func calculatePartOne() -> Int {
        findAntinodes().count
    }

    func calculatePartTwo() -> Int {
        findAntinodes(usingUpdatedModel: true).count
    }
}
