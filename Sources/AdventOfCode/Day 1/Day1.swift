struct Day1: Solution {
    static let day = 1

    let lists: ([Int], [Int])

    /// Initialise your solution
    ///
    /// - parameters:
    ///   - input: Contents of the `Day1.input` file within the same folder as this source file
    init(input: String) {
        lists = input
            .components(separatedBy: .newlines)
            .map {
                $0
                .components(separatedBy: .whitespaces)
                .compactMap(Int.init)
            }
            .reduce(into: ([], [])) { partialResult, line in
                guard
                    let first = line.first,
                    let second = line.last else {
                    return
                }
                partialResult.0.append(first)
                partialResult.1.append(second)
            }
    }

    /// Return your answer to the main activity of the advent calendar
    ///
    /// If you need to, you can change the return type of this method to any type that conforms to `CustomStringConvertible`, i.e. `String`, `Float`, etc.
    func calculatePartOne() -> Int {
        let list1Sorted = lists.0.sorted()
        let list2Sorted = lists.1.sorted()
        return zip(list1Sorted, list2Sorted).map {
            abs($0.0 - $0.1)
        }.reduce(0, +)
    }

    /// Return your solution to the extension activity
    /// _ N.B. This is only unlocked when you have completed part one! _
    func calculatePartTwo() -> Int {
        let leftListSorted = lists.0.sorted()

        let rightListCount = Dictionary(
            lists.1.map { ($0, 1) },
            uniquingKeysWith: +
        )

        return leftListSorted.map {
            $0 * (rightListCount[$0] ?? 0)
        }.reduce(0, +)
    }
}
