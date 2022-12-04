struct Day4: Solution {
    static let day = 4

    let sections: [[ClosedRange<Int>]]
    
    init(input: String) {
        sections = input
            .components(separatedBy: .newlines)
            .filter { !$0.isEmpty }
            .compactMap {
                $0
                    .components(separatedBy: .punctuationCharacters)
                    .compactMap(Int.init)
                    .chunks(ofCount: 2)
                    .compactMap { values in
                        guard let first = values.first,
                              let last = values.last else { return nil }
                        return first...last
                    }
            }
    }

    func calculatePartOne() -> Int {
        return sections.map {
            $0[0].fullyContains($0[1]) ||
            $0[1].fullyContains($0[0])
        }.filter { $0 }.count
    }
    
    func calculatePartTwo() -> Int {
        return sections.map {
            $0[0].overlaps($0[1]) ||
            $0[1].overlaps($0[0])
        }.filter { $0 }.count
    }
}

extension ClosedRange<Int> {
    func fullyContains(_ range: ClosedRange<Int>) -> Bool {
        range.clamped(to: self) == range
    }
}
