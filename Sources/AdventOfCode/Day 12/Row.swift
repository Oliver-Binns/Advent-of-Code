struct Row: Equatable {
    let springs: [Spring]
    let groups: [Int]
    
    static func == (lhs: Row, rhs: Row) -> Bool {
        lhs.springs == rhs.springs &&
        lhs.groups == rhs.groups
    }
    
    
    var requiredGroups: [Spring] {
        groups.map { count in
            (0..<count).map { _ in
                Spring.damaged
            }
        }
        .joined(separator: [.operational])
        .map { $0 }
    }
    
    var possibleArrangements: Int {
        arrangements(for: requiredGroups, in: springs)
    }
    
    var part2: Row {
        Row(springs: (0..<5).map { _ in
                springs
            }
            .joined(separator: [.unknown])
            .map { $0 },
            groups: (0..<5).flatMap { _ in
                groups
            }
        )
    }
    
    init(springs: [Spring],
         groups: [Int]) {
        self.springs = springs
        self.groups = groups
    }
    
    init?(rawValue: String) {
        let components = rawValue
            .components(separatedBy: .whitespaces)
        
        springs = components[0]
            .compactMap(Spring.init)
        
        groups = components[1]
            .components(separatedBy: .punctuationCharacters)
            .compactMap(Int.init)
    }
    
    func removeTopSprings(for groups: [Spring], in springs: [Spring]) -> ([Spring], [Spring]) {
        let firstOperationalSpring = groups.firstIndex(of: .operational)
            ?? groups.count
        
        guard springs[0..<firstOperationalSpring].allSatisfy({
            $0 != .operational
        }) else {
            return ([.damaged], [])
        }
        
        return (groups[firstOperationalSpring...].map { $0 },
                springs[firstOperationalSpring...].map { $0 })
    }
    
    struct CachedItem: Hashable {
        let groups: [Spring]
        let springs: [Spring]
    }
    
    final class Cache {
        var _cache: [CachedItem: Int] = [:]
        
        subscript(groups: [Spring], springs: [Spring]) -> Int? {
            _cache[.init(groups: groups, springs: springs)]
        }
        
        func update(groups: [Spring], springs: [Spring], value: Int) {
            _cache[.init(groups: groups, springs: springs)] = value
        }
    }
    
    private var cache = Cache()
    
    private func arrangements(for groups: [Spring],
                              in springs: [Spring]) -> Int {
        // there must be enough springs remaining
        // to match all groups
        guard groups.count <= springs.count else {
            return 0
        }
        // if there are no groups left
        guard groups.isNotEmpty else {
            // all remaining springs must be operational or unknown
            return springs.allSatisfy({ $0 != .damaged }) ? 1 : 0
        }
        
        if let cached = cache[groups, springs] {
            return cached
        }
        
        guard groups[0] == .damaged else {
            switch springs[0] {
            case .damaged:
                // expected a gap in damaged springs;
                // this combination is invalid
                return 0
            case .operational, .unknown:
                // remove at top of pile and recurse
                let value = arrangements(for: groups[1...].map { $0 },
                                       in: springs[1...].map { $0 })
                cache.update(groups: groups, springs: springs, value: value)
                return value
            }
        }
        
        // if we expect damaged...
        // we must remove all damaged springs in the group
        let (newGroups, newSprings) = removeTopSprings(for: groups, in: springs)
        
        switch springs[0] {
        case .damaged:
            // expected damaged.. got damaged
            // remove all springs in this group
            // single-valid combination
            let value = arrangements(for: newGroups, in: newSprings)
            cache.update(groups: groups, springs: springs, value: value)
            return value
        case .operational:
            // expected damaged...
            // got operational, remove top spring and continue check
            let value = arrangements(for: groups,
                                     in: springs[1...].map { $0 })
            cache.update(groups: groups, springs: springs, value: value)
            return value
        case .unknown:
            // expected damaged.. this is either damaged OR operational
            // combine above two combinations
            let value = arrangements(for: newGroups, in: newSprings) +
                arrangements(for: groups,
                             in: springs[1...].map { $0 })
            cache.update(groups: groups, springs: springs, value: value)
            return value
        }
    }
}
