// swift-tools-version: 5.6
import PackageDescription

let package = Package(
    name: "AdventOfCode",
    platforms: [
        .iOS(.v15),
        .macOS(.v12)
    ],
    targets: [
        .executableTarget(name: "AdventOfCode",
                          resources: [.copy("Resources")]),
        .testTarget(name: "AdventOfCodeTests",
                    dependencies: ["AdventOfCode"],
                    resources: [.copy("Resources")])
    ]
)
