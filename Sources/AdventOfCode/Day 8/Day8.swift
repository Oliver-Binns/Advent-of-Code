struct Day8: Solution {
    static let day = 8
    
    let grid: [[Tree]]
    
    init(input: String) {
        grid = input
            .components(separatedBy: .newlines)
            .map {
                $0.compactMap(String.init).compactMap(Int.init)
            }
            .filter(!\.isEmpty)
            .enumerated()
            .map { row in
                row.element.enumerated().map { tree in
                    Tree(x: tree.offset,
                               y: row.offset,
                               height: tree.element)
                }
            }
    }
    
    func calculatePartOne() -> Int { // aiming for 1782
        visibleFromEdge().count
    }
    
    func calculatePartTwo() -> Int { // aiming for 474606 (at 47, 22)
        grid.flatMap { row in
            row.map { tree in
                scenicScore(atX: tree.x, y: tree.y)
            }
        }.max().unsafelyUnwrapped
    }
}

extension Day8 {
    typealias Direction = (vertical: Int, horizontal: Int)
    var allDirections: [Direction] {
        [
            (vertical: -1, horizontal: 0),
            (vertical: 0, horizontal: -1),
            (vertical: 1, horizontal: 0),
            (vertical: 0, horizontal: 1)
        ]
    }
    
    func scenicScore(atX x: Int, y: Int) -> Int {
        allDirections.map {
            visibleInDirection(direction: $0, fromX: x, y: y, comparison: >=)
        }
        .map(\.count)
        .reduce(1, *)
    }
    
    func visibleTrees(atX x: Int, y: Int) -> Set<Tree> {
        allDirections.reduce(Set<Tree>()) { partialResult, direction in
            partialResult
                .union(visibleInDirection(direction: direction, fromX: x, y: y))
        }
    }
    
    func visibleInDirection(direction: Direction,
                            fromX x: Int, y: Int,
                            comparison: (Int, Int) -> Bool = (>)) -> Set<Tree> {
        var maxHeightSeen = -1
        var trees: Set<Tree> = []
        
        var newX = x
        var newY = y
        
        while true {
            newX += direction.horizontal
            newY += direction.vertical
            
            guard newX >= 0, newY >= 0,
                  newX < grid[0].count, newY < grid.count else {
                return trees
            }
            
            let tree = grid[newY][newX]
            if comparison(tree.height, maxHeightSeen) {
                maxHeightSeen = tree.height
                trees.insert(tree)
                
                if x >= 0, y >= 0,
                   x < grid[0].count, y < grid.count,
                   maxHeightSeen >= grid[y][x].height {
                    return trees
                }
            }
        }
    }
    
    func visibleFromEdge() -> Set<Tree> {
        let height = grid.count
        let width = grid[0].count
        
        return (-1...height).flatMap { y in
            (-1...width).compactMap { x -> Position? in
                guard x == -1 || x == width ||
                        y == -1 || y == height else {
                    return nil
                }
                return Position(x: x, y: y)
            }
        }.reduce(Set<Tree>()) { partialResult, position in
            partialResult
                .union(visibleTrees(atX: position.x, y: position.y))
        }
    }
}

struct Tree: Hashable, Equatable {
    let x: Int
    let y: Int
    let height: Int
}

struct Position: Hashable {
    let x: Int
    let y: Int
    
    static var origin: Position {
        .init(x: 0, y: 0)
    }
}
