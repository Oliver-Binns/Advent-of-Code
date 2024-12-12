struct Day12: Solution {
    static let day = 12

    let garden: Grid<Character>

    var plots: [Set<Point>] {
        var used: Set<Point> = []
        var plots: [Set<Point>] = []

        for row in garden.values.indices {
            for column in garden.values[row].indices {
                let point = Point(x: column, y: row)
                guard !used.contains(point) else {
                    continue
                }

                let plot = findPlotNeighbours(
                    of: point,
                    notIn: used
                )

                plots.append(plot)
                used.formUnion(plot)
            }
        }

        return plots
    }

    func findPlotNeighbours(
        of point: Point,
        notIn used: Set<Point> = []
    ) -> Set<Point> {
        let neighbours = point.neighbours
            .filter(garden.isWithinBounds)
            .filter { garden[$0] == garden[point] }
            .filter { !used.contains($0) }

        return neighbours.reduce([point]) { partialResult, point in
            let plot = partialResult.union([point])

            return plot
                .union(findPlotNeighbours(
                    of: point,
                    notIn: plot.union(used)
                ))
        }
    }

    init(input: String) {
        garden = Grid(string: input)
    }
    
    func calculatePartOne() -> Int {
        plots
            .map {
                (calculateArea(for: $0), calculatePerimeter(for: $0))
            }
            .map(*)
            .reduce(0, +)
    }
    
    func calculatePartTwo() -> Int {
        0
    }

    func calculateArea(for plot: Set<Point>) -> Int {
        plot.count
    }

    func calculatePerimeter(for plot: Set<Point>) -> Int {
        plot.map { point in
            point
                .neighbours
                .filter { !plot.contains($0) }
                .count
        }.reduce(0, +)
    }
}
