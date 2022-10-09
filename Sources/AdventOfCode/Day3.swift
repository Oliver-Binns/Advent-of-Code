import Foundation
 
struct Day3 {
    let day = 3
    let map: [String]
    
    init(input: String) {
        map = input
            .split(whereSeparator: { $0.isNewline })
            .map(String.init)
    }
    
    func traverseSlope(across: Int, down: Int) -> Int {
        var count = 0

        for index in 0..<map.count
        where index % down == 0 {
            let across = (index / down) * across
            let mapRow = map[index]

            let squareIndex = mapRow.index(mapRow.startIndex, offsetBy: across % mapRow.count)
            let squareContents = mapRow[squareIndex]
            count += (squareContents == "#") ? 1 : 0
        }

        return count
    }
}

extension Day3: Solution {
    func calculatePartOne() -> String {
        traverseSlope(across: 3, down: 1).description
    }
    
    func calculatePartTwo() -> String {
        [
            (across: 1, down: 1),
            (across: 3, down: 1),
            (across: 5, down: 1),
            (across: 7, down: 1),
            (across: 1, down: 2)
        ]
        .map { traverseSlope(across: $0.across, down: $0.down) }
        .reduce(1, *)
        .description
    }
}
