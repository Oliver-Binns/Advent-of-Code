struct IslandAlmanac {
    let seedsToPlant: [Int]
    let mappings: [[Mapping]]
    
    var seedRangesToPlant: [Range<Int>] {
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
    
    var locations: [Int] {
        seedsToPlant.map(mapToLocation(seed:))
    }
    
    var partTwoLocations: [Range<Int>] {
        var ranges = seedRangesToPlant
    
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
    
    private func mapToLocation(seed: Int) -> Int {
        mappings.reduce(seed) { partialResult, mappings in
            guard let mapping = mappings
                .first(where: { $0.contains(item: partialResult) }) else {
                return partialResult
            }
            return mapping.map(item: partialResult)
        }
    }
}
