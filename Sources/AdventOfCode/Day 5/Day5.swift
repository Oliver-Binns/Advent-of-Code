struct Day5: Solution {
    static let day = 5

    let dependencies: [Int: Set<Int>]
    let updates: [[Int]]

    init(input: String) {
        let parts = input.split(separator: "\n\n")

        dependencies = parts[0]
            .components(separatedBy: .newlines)
            .map {
                $0.components(separatedBy: "|")
                    .compactMap(Int.init)
            }
            .compactMap { array -> (Int, Int)? in
                guard let first = array.first,
                      let last = array.last else {
                    return nil
                }
                return (first, last)
            }
            .reduce(into: [:]) { partialResult, dependency in
                partialResult[
                    dependency.0,
                    default: []
                ].insert(dependency.1)
            }

        updates = parts[1]
            .components(separatedBy: .newlines)
            .map {
                $0.components(separatedBy: .punctuationCharacters)
                    .compactMap(Int.init)
            }
            .filter { !$0.isEmpty }
    }
    
    func calculatePartOne() -> Int {
        updates
            .filter(isValid)
            .map(middlePage)
            .reduce(0, +)
    }
    
    func calculatePartTwo() -> Int {
        updates
            .filter { !isValid(update: $0) }
            .map {
                $0.sorted { lhs, rhs in
                    dependencies[lhs]?.contains(rhs) ?? false
                }
            }
            .map(middlePage)
            .reduce(0, +)
    }

    func isValid(update: [Int]) -> Bool {
        update.sorted { lhs, rhs in
            dependencies[lhs]?.contains(rhs) ?? false
        } == update
    }

    func middlePage(of update: [Int]) -> Int {
        let middleIndex = update.count / 2
        return update[middleIndex]
    }

}




