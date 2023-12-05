struct Day5: Solution {
    static let day = 5
    
    let almanac: IslandAlmanac
    
    init(input: String) {
        almanac = IslandAlmanac(rawString: input)
    }
    
    func calculatePartOne() -> Int {
        almanac.minLocation(for: \.part1Ranges)
    }
    
    func calculatePartTwo() -> Int {
        almanac.minLocation(for: \.part2Ranges)
    }
}
