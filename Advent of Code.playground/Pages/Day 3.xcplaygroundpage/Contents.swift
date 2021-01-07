//: [Previous](@previous)
import Cocoa

guard let fileURL = Bundle.main
        .url(forResource: "Map", withExtension: nil),
      let fileContents = try? String(contentsOf: fileURL) else {
    preconditionFailure("Could not decode input data")
}

let map = fileContents
    .split(whereSeparator: { $0.isNewline })
    .map(String.init)

let traverseSlope = { (across: Int, down: Int) -> Int in
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

print("Challenge 1 Solution:", traverseSlope(3, 1))


let count = [
    (across: 1, down: 1),
    (across: 3, down: 1),
    (across: 5, down: 1),
    (across: 7, down: 1),
    (across: 1, down: 2)
]
.map { traverseSlope($0.across, $0.down) }
.reduce(1, *)

print("Challenge 2 Solution:", count)


//: [Next](@next)
