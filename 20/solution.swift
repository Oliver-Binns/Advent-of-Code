import Foundation

try print("""
Day 20:
Sample Answer: \(solve(filename: "sample.input"))
Solution Answer: \(solve(filename: "solution.input"))

Extension Task:
Sample Answer: \(solveExtension(filename: "sample.input"))
Solution Answer: \(solveExtension(filename: "solution.input"))
""")

// MARK: - Parse input into data structure

func openFile(filename: String) throws -> String {
    let cwd = FileManager.default.currentDirectoryPath
    return try String(contentsOfFile: "\(cwd)/\(filename)", encoding: .utf8)
        .trimmingCharacters(in: .whitespacesAndNewlines)
}

enum Pixel: String {
    case light = "#"
    case dark = "."
    case empty = " "
}

typealias Algorithm = [Pixel]
typealias Grid = [[Pixel]]

func parseInputString(_ input: String) -> (Algorithm, Grid) {
    let string = input.components(separatedBy: "\n\n")
    return (parseAlgorithm(string: string[0]), parseGrid(string: string[1]))
}

func parseAlgorithm(string: String) -> Algorithm {
    string.map(String.init).compactMap(Pixel.init)
}

func parseGrid(string: String) -> Grid {
    string.components(separatedBy: "\n")
        .map { $0.map(String.init).compactMap(Pixel.init) }
}

// MARK: - Data Structure

func enhanceImage(grid: Grid, using algorithm: Algorithm, iteration: Int) -> Grid {
    // The algorithm for the actual task flips dark space into light
    let algorithmFlipsDarkSpace = algorithm[0] == .light
    // When the outer image has been inverted, in order to handle infinite space,
    // we need to treat unexplored space as light space (i.e. every odd numbered iteration)
    let outOfBounds: Pixel = algorithmFlipsDarkSpace ? (iteration % 2 == 0 ? .dark: .light) : .dark

    var newGrid: Grid = []

    for y in 0..<grid.count {
        newGrid.append([])

        for x in 0..<grid[0].count{
            let adjacentPixels = getAdjacentPixels(toX: x, y: y, in: grid)
            let binaryRepresentation = convertToBinary(pixels: adjacentPixels,
                                                       replaceEmptyWith: outOfBounds)
            let newValue = algorithm[binaryRepresentation]
            newGrid[y].append(newValue)
        }
    }

    return newGrid
}

func getPixel(atX x: Int, y: Int, in grid: Grid) -> Pixel {
    guard x < 0 || y < 0 ||
          x >= grid[0].count ||
          y >= grid.count else {
              return grid[y][x]
          }
    return .empty
}

func getAdjacentPixels(toX x: Int, y: Int, in grid: Grid) -> [Pixel] {
    [
        (x-1, y-1), (x, y-1), (x+1, y-1),
        (x-1, y), (x, y), (x+1, y),
        (x-1, y+1), (x, y+1), (x+1, y+1),
    ].map { getPixel(atX: $0.0, y: $0.1, in: grid) }
}

func convertToBinary(pixels: [Pixel], replaceEmptyWith pixel: Pixel) -> Int {
    let stringRepresentation = pixels
        .map { $0 == .empty ? pixel : $0  }
        .map {
            $0 == .light ? "1" : "0"
        }.joined()
    return Int(stringRepresentation, radix: 2)!
}

func padImage(_ image: Grid, padding: Int = 1) -> Grid {
    var paddedImage: Grid = []

    for y in -padding..<image.count + padding {
        paddedImage.append([])

        for x in -padding..<image[0].count + padding {
            paddedImage[y + padding].append(getPixel(atX: x, y: y, in: image))
        }
    }

    return paddedImage
}

// MARK: - Challenge 1 Solution

func solve(filename: String, iterations: Int = 2) throws -> Int {
    let input = try openFile(filename: filename)
    let (algorithm, grid) = parseInputString(input)

    let finalImage = (0..<iterations).reduce(grid) {
        enhanceImage(grid: padImage($0), using: algorithm, iteration: $1)
    }

    return finalImage.reduce(0) {
        $0 + $1.filter { $0 == .light }.count
    }
}

// MARK: - Challenge 2 Solution

func solveExtension(filename: String) throws -> Int {
    try solve(filename: filename, iterations: 50)
}
