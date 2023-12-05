struct Day5: Solution {
    static let day = 5
    
    let almanac: IslandAlmanac
    
    init(input: String) {
        almanac = IslandAlmanac(rawString: input)
    }
    
    func calculatePartOne() -> Int {
        guard let min = almanac.locations.min() else {
            preconditionFailure("Unable to find location value")
        }
        return min
    }
    
    func calculatePartTwo() -> Int {
        guard let min = almanac.partTwoLocations.map(\.lowerBound).min() else {
            preconditionFailure("Unable to find location value")
        }
        return min
    }
}
