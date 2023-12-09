// swift-tools-version: 5.8
import PackageDescription

let inputFiles: [Resource] = (1...25)
    .map { "Day \($0)/Day\($0).input" }
    .map {  .process($0) }

let package = Package(
    name: "AdventOfCode",
    platforms: [
        .iOS(.v15),
        .macOS(.v13)
    ],
    dependencies: [
        // Some recommended packages here, you might like to try them!
        
        // Sequence and collection algorithms
        // i.e. rotations, permutations, etc.
        .package(url: "https://github.com/apple/swift-algorithms", from: "1.0.0"),
        
        // Extra data structure implementations
        // i.e. OrderedSet, Deque, Heap
        //.package(url: "https://github.com/apple/swift-collections.git",
        //         .upToNextMinor(from: "1.1.0")),
        
        // Support for numerical computing, including complex numbers
        //.package(url: "https://github.com/apple/swift-numerics", from: "1.0.0"),
    ],
    targets: [
        .executableTarget(name: "AdventOfCode", 
                          dependencies: [
                            .product(name: "Algorithms", package: "swift-algorithms")
                          ],
                          resources: inputFiles),
        .testTarget(name: "AdventOfCodeTests",
                    dependencies: ["AdventOfCode"],
                    resources: inputFiles + [.process("Day 1/Day1-Part2.input")])
    ]
)
