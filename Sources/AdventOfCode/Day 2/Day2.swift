struct Day2: Solution {
    static let day = 2

    let reports: [Report]

    init(input: String) {
        reports = input
            .components(separatedBy: .newlines)
            .map {
                $0
                .components(separatedBy: .whitespaces)
                .compactMap(Int.init)
            }
            .filter { !$0.isEmpty }
            .map(Report.init)
    }

    func calculatePartOne() -> Int {
        reports.filter {
            $0.isSafe()
        }.count
    }
    
    func calculatePartTwo() -> Int {
        reports.filter {
            $0.isSafe(problemDampener: true)
        }.count
    }
}

extension Day2 {
    struct Report {
        let levels: [Int]
    }
}

extension Day2.Report: ExpressibleByArrayLiteral {
    init(arrayLiteral elements: Int...) {
        self.levels = elements
    }
}

extension Day2.Report: Equatable { }
extension Day2.Report {
    func isSafe(problemDampener: Bool = false) -> Bool {
        return levels.isSafe(
            problemDampener: problemDampener
        ) || levels.reversed().isSafe(
            problemDampener: problemDampener
        )
    }
}

fileprivate extension RandomAccessCollection where Index == Int,
                                                   Element == Int {
    func isSafe(
        fromIndex index: Index = 0,
        problemDampener: Bool = false
    ) -> Bool {
        let exit = {
            guard problemDampener else {
                return false
            }
            return correct(fromIndex: index)
        }

        let first = self[index]
        let second = self[index.advanced(by: 1)]

        let difference = second - first

        guard (0...3).contains(abs(difference)) else {
            return exit()
        }

        guard difference > 0 else {
            return exit()
        }

        guard count - index <= 2 else {
            return isSafe(
                fromIndex: index.advanced(by: 1),
                problemDampener: problemDampener
            )
        }

        return true
    }

    func correct(fromIndex index: Index) -> Bool {
        let first = [self[index]]
        let rest = self[(index + 2)...]

        guard !rest.isEmpty else {
            return true
        }

        let firstSafe = (first + rest).isSafe(
            problemDampener: false
        )

        var second = [self[index + 1]]
        // there may be a gap
        if index > 0 {
            second.insert(self[index-1], at: 0)
        }
        let secondSafe = (second + rest).isSafe(
            problemDampener: false
        )

        return firstSafe || secondSafe
    }
}
