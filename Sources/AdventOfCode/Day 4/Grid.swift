struct Grid<Element> {
    let values: [[Element]]

    subscript(point: Point) -> Element {
        values[point.y][point.x]
    }

    func isWithinBounds(point: Point) -> Bool {
       (0..<values.count).contains(point.y)
            && (0..<values[point.y].count).contains(point.x)
    }
}

extension Grid where Element == Character {
    init(string: String) {
        self.values = string
            .components(separatedBy: .newlines)
            .map {
                $0.reduce([Character]()) {
                    $0 + [$1]
                }
            }
            .filter { !$0.isEmpty }
    }
}

extension Grid where Element: Equatable {
    func findPositions(of element: Element) -> [Point] {
        values.enumerated().flatMap { y, row in
            row.enumerated().compactMap { x, cell in
                guard cell == element else {
                    return nil
                }
                return Point(x: x, y: y)
            }
        }
    }

    func countX(
        origin: Element,
        value1: Element,
        value2: Element
    ) -> Int {
        findPositions(of: origin)
            .filter { point in
                // where diagonals are all in the grid
                Direction.diagonals.map {
                    point.move(in: $0)
                }.allSatisfy(isWithinBounds)
            }
            .filter { point in
                // diagonals are different
                guard self[point.move(in: .northEast)] != self[point.move(in: .southWest)],
                      self[point.move(in: .northWest)] != self[point.move(in: .southEast)] else {
                    return false
                }

                // both match value1 or value2
                return [Direction.northEast, .northWest, .southEast, .southWest]
                    .map { point.move(in: $0) }
                    .map { self[$0] }
                    .allSatisfy { [value1, value2].contains($0) }
            }
            .count
    }
}

extension Grid where Element == Character {
    func countOccurences(of word: String) -> Int {
        guard let first = word.first else {
            return 0
        }
        return findPositions(of: first).map {
            findWord(word, startingAt: $0)
        }.reduce(0, +)
    }

    func findWord(_ word: String, startingAt point: Point) -> Int {
        Direction.allCases.count { direction in
            let positions = (0..<word.count)
                .map {
                    point.move(distance: $0, in: direction)
                }

            guard positions.allSatisfy(isWithinBounds) else {
                return false
            }

            return word == positions.reduce("") {
                $0 + String(values[$1.y][$1.x])
            }
        }
    }
}

extension Grid: CustomStringConvertible
where Element: CustomStringConvertible {
    var description: String {
        values
            .map { $0.map(\.description).joined() }
            .joined(separator: "\n")
    }
}
