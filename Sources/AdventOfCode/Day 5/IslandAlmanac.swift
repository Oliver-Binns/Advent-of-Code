struct IslandAlmanac {
    let seedsToPlant: [Int]
    let mappings: [[Mapping]]
    
    var part1Ranges: [Range<Int>] {
        seedsToPlant
            .map { Range(start: $0, length: 1) }
    }
    
    var part2Ranges: [Range<Int>] {
        seedsToPlant.chunked(into: 2).map {
            Range(start: $0[0], length: $0[1])
        }
    }
    
    init(rawString: String) {
        let components = rawString
            .split(separator: "\n\n")
        
        seedsToPlant = components[0]
            .split(separator: ":")[1]
            .components(separatedBy: .whitespaces)
            .compactMap(Int.init)
        
        mappings = components[1...].map {
            $0
                .components(separatedBy: .newlines)[1...]
                .filter { !$0.isEmpty }
                .map(Mapping.init)
        }
    }
    
    func minLocation(for seeds: KeyPath<Self, [Range<Int>]>) -> Int {
        guard let min = findLocationRanges(seeds: self[keyPath: seeds])
            .map(\.lowerBound)
            .min() else {
            preconditionFailure("Unable to find location value")
        }
        return min
    }

    private func findLocationRanges(seeds: [Range<Int>]) -> [Range<Int>] {
        var ranges = seeds
    
        // for each mapping, i.e. seed -> soil
        for mapping in mappings {
            // for each set of map within the mapping, i.e. 50 -> 98
            var unmappedRanges = ranges
            var mappedRanges: [Range<Int>] = []
            
            while unmappedRanges.contains(where: { range in
                mapping.contains(where: { map in map.contains(range: range) })
            }) {
                let range = unmappedRanges.removeFirst()
                if let mapping = mapping.first(where: { $0.contains(range: range) }) {
                    let (lower, mid, upper) = mapping.map(range: range)
                    lower.flatMap { unmappedRanges.append($0) }
                    mappedRanges.append(mid)
                    upper.flatMap { unmappedRanges.append($0) }
                } else {
                    mappedRanges.append(range)
                }
            }
            
            ranges = unmappedRanges + mappedRanges
        }
        
        return ranges
    }
}
