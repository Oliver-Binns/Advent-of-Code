import Foundation

try print("""
Day 5:
Sample Answer: \(solve(filename: "sample.input"))
Solution Answer: \(solve(filename: "solution.input"))

Extension Task:
Sample Answer: \(solveExtension(filename: "sample.input"))
Solution Answer: \(solveExtension(filename: "solution.input"))
""")

// MARK: - Parse input into data structure

enum InputError: Error {
    case invalidFormat
}

func openFile(filename: String) throws -> String {
    let cwd = FileManager.default.currentDirectoryPath
    return try String(contentsOfFile: "\(cwd)/\(filename)", encoding: .utf8)
}

func parseLines(input: String) throws -> [Line] {
    try input
        .components(separatedBy: "\n")
        .filter { !$0.isEmpty }
        .map(parseLine)
}

func parseTuple<T>(input: String,
                   separatedBy separator: String,
                   conversion: (String) throws -> T) throws -> (T, T) {
    let values = try input
        .components(separatedBy: separator)
        .map(conversion)
    return (values[0], values[1])
}

func parseLine(input: String) throws -> Line {
    let coordinates = try parseTuple(input: input,
                                     separatedBy: " -> ",
                                     conversion: parseCoordinate)
    return Line(origin: coordinates.0, destination: coordinates.1)
}

func parseCoordinate(input: String) throws -> Coordinate {
    let positions = try parseTuple(input: input,
                                   separatedBy: ",",
                                   conversion: Int.init)
    guard let x = positions.0, let y = positions.1 else {
        throw InputError.invalidFormat
    }
    return Coordinate(x: x, y: y)
}

// MARK: - Data Structure

func range(_ start: Int, _ end: Int) -> [Int] {
    start < end ? Array(start...end) : (end...start).reversed()
}

struct Line {
    let origin: Coordinate
    let destination: Coordinate
    
    var isHorizontal: Bool {
        origin.x == destination.x
    }
    
    var isVertical: Bool {
        origin.y == destination.y
    }
    
    var allPoints: [Coordinate] {
        if isHorizontal {
            return range(origin.y, destination.y).map {
                Coordinate(x: origin.x, y: $0)
            }
        } else if isVertical {
            return range(origin.x, destination.x).map {
                Coordinate(x: $0, y: origin.y)
            }
        } else {
            return zip(range(origin.x, destination.x), range(origin.y, destination.y)).map {
                Coordinate(x: $0, y: $1)
            }
        }
    }
}

struct Coordinate: Hashable {
    let x: Int
    let y: Int
}

// MARK: - Solve Challenge 1

func solve(filename: String,
           filtering filter: (Line) -> Bool = { $0.isHorizontal || $0.isVertical }) throws -> Int {
    let input = try openFile(filename: filename)
    return try parseLines(input: input)
        .filter(filter)
        .flatMap { $0.allPoints }
        .reduce(into: [Coordinate: Int]()) { dictionary, coordinate in
            if let count = dictionary[coordinate] {
                dictionary[coordinate] = count + 1
            } else {
                dictionary[coordinate] = 1
            }
        }
        .values
        .filter { $0 >= 2 }
        .count
}


// MARK: - Solve Challenge 2

func solveExtension(filename: String) throws -> Int {
    try solve(filename: filename, filtering: { _ in true })
}

