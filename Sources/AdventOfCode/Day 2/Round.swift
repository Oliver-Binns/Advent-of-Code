extension Dictionary where Key == Day2.Cube,
                           Value == Int {
    var power: Int {
        values.reduce(1, *)
    }
    
    func isPossible(with cubes: [Key: Value]) -> Bool {
        cubes.allSatisfy { (cube, value) in
            value >= self[cube, default: 0]
        }
    }
}
