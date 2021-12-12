import Foundation

try print("""
Day 12:
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
}

func parseLines(input: String) -> [[String]] {
    input
        .components(separatedBy: "\n")
        .filter { !$0.isEmpty }
        .map { $0.components(separatedBy: "-") }
        .filter { $0.count == 2 }
}

func parseGraph(connections: [[String]]) -> [String: [String]] {
    connections
        .map { ($0.first!, $0.last!) }
        .reduce(into: [:]) { dictionary, newValue in
        dictionary[newValue.0, default: []].append(newValue.1)
        dictionary[newValue.1, default: []].append(newValue.0)
    }
}

// MARK: - Challenge 1 Solution
func solve(filename: String, stopFilter: ([String], String) -> Bool = { !$0.contains($1) }) throws -> Int {
    let input = try openFile(filename: filename)
    let connections = parseLines(input: input)
    let graph = parseGraph(connections: connections)

    var routes = [["start"]]
    while !routes.allSatisfy({ $0.last == "end" }) {
        routes = routes.flatMap { route -> [[String]] in
            guard let lastStop = route.last,
                  lastStop != "end" else {
                return [route]
            }
            
            return graph[lastStop, default: []]
                .filter { $0.first!.isUppercase || stopFilter(route, $0) }
                .map { route + [$0] }
        }
    }

    return routes.count
}

// MARK: - Challenge 2 Solution
func solveExtension(filename: String) throws -> Int {
    try solve(filename: filename) { route, newStop in
        guard newStop != "start" else { return false }
        
        var stops = Set<String>()
        var multipleAttempts: Bool = false
        
        for stop in route {
            if stops.contains(stop) && stop.first!.isLowercase {
                if multipleAttempts {
                    return false
                } else {
                    multipleAttempts = true
                }
            } else {
                stops.insert(stop)
            }
        }
        
        return true
    }
}
