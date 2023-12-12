struct Day10: Solution {
    static let day = 10
    
    let map: PipeMap
    
    init(input: String) {
        map = PipeMap(rawValue: input)
    }
    
    func calculatePartOne() -> Int {
        map.calculateFurthestPosition()
    }
    
    func calculatePartTwo() -> Int {
        map.calculateEnclosedTiles()
    }
}
