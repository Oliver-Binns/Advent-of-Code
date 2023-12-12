struct Row: Equatable {
    let springs: [Spring]
    let groups: [Int]
    
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
    
    func arrangements(for groups: [Spring],
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
        
        guard groups[0] == .damaged else {
            switch springs[0] {
            case .damaged:
                // expected a gap in damaged springs;
                // this combination is invalid
                return 0
            case .operational, .unknown:
                // remove at top of pile and recurse
                return arrangements(for: groups[1...].map { $0 },
                                    in: springs[1...].map { $0 })
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
            return arrangements(for: newGroups, in: newSprings)
        case .operational:
            // expected damaged...
            // got operational, remove top spring and continue check
            return arrangements(for: groups,
                                in: springs[1...].map { $0 })
        case .unknown:
            // expected damaged.. this is either damaged OR operational
            // combine above two combinations
            return arrangements(for: newGroups, in: newSprings) +
                arrangements(for: groups,
                             in: springs[1...].map { $0 })
        }
    }
}
