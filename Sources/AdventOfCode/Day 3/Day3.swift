import Algorithms

struct Day3: Solution {
    static let day = 3
    
    let rucksacks: [String]
    
    var intersections: [String] {
        rucksacks
            .map(compartments(in:))
            .compactMap(intersection)
    }
    
    init(input: String) {
        rucksacks = input
            .components(separatedBy: .newlines)
            .filter { !$0.isEmpty }
    }
    
    func calculatePartOne() -> Int {
        intersections
            .map(priority)
            .reduce(0, +)
    }
    
    var badges: [String] {
        groups(rucksacks: rucksacks)
            .compactMap(intersection(_:))
    }
    
    func calculatePartTwo() -> Int {
        badges
            .map(priority)
            .reduce(0, +)
    }
}

extension Day3 {
    func compartments(in rucksack: String) -> [Set<String>] {
        let count = rucksack.count / 2
        
        let first = rucksack.prefix(count).map(String.init)
        let last = rucksack.suffix(count).map(String.init)
        
        return [Set(first), Set(last)]
    }
    
    func intersection(_ sets: [Set<String>]) -> String? {
        sets.suffix(from: 1).reduce(sets[0]) { partialResult, newValue in
            newValue.intersection(partialResult)
        }.first
    }
    
    func priority(of item: String) -> Int {
        let asciiValue = item.compactMap(\.asciiValue)[0]
        return Int(asciiValue) - (asciiValue > 96 ? 96 : 38)
    }

    func groups(rucksacks: [String]) -> [[Set<String>]] {
        rucksacks
            .chunks(ofCount: 3)
            .map {
                $0.map {
                    Set($0.map(String.init))
                }
            }
    }
}
