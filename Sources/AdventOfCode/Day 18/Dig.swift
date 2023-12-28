struct DigInstruction: Equatable {
    let direction: DigDirection
    let distance: Int
    
    init(direction: DigDirection, 
         distance: Int) {
        self.direction = direction
        self.distance = distance
    }
    
    init?(rawValue: String) {
        let components = rawValue
            .components(separatedBy: .whitespaces)
        
        guard let direction = DigDirection(rawValue: components[0]),
              let distance = Int(components[1]) else {
            return nil
        }
        self.init(direction: direction,
                  distance: distance)
    }
}

enum DigDirection: String {
    case up = "U"
    case down = "D"
    case left = "L"
    case right = "R"
}
