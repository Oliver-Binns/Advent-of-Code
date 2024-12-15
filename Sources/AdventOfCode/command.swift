import Foundation

@main
struct Runner {
    static var timeFormatter: DateComponentsFormatter {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.maximumUnitCount = 2
        formatter.unitsStyle = .short
        formatter.zeroFormattingBehavior = .pad
        return formatter
    }
    
    static func main() async throws {
        let solutions: [any Solution.Type] = [
//            Day1.self,
//            Day2.self,
//            Day3.self,
//            Day4.self,
//            Day5.self,
//            Day6.self,
//            Day7.self,
//            Day8.self,
//            Day9.self,
//            Day10.self,
//            Day11.self,
//            Day12.self,
//            Day13.self,
//            Day14.self,
            Day15.self,
//            Day16.self,
//            Day17.self,
//            Day18.self,
//            Day19.self,
//            Day20.self,
//            Day21.self,
//            Day22.self,
//            Day23.self,
//            Day24.self,
//            Day25.self
        ]

        for day in solutions {
            try await runDay(day)
        }
    }
    
    private static func runDay(_ day: any Solution.Type) async throws {
        let inputString = try getInputString(filename: "Day\(day.day).input")
        let solution = day.init(input: inputString)
        
        print("Day \(day.day)")
        
        await run(note: "Part One",
            calculate: solution.calculatePartOne)
        await run(note: "Part Two",
            calculate: solution.calculatePartTwo)
        print("\n")
    }
    
    static func run(
        note: String,
        calculate: () async -> CustomStringConvertible
    ) async {
        let start = Date()
        await print("\t\(note): ", calculate())
        let end = Date()
        let duration = end.timeIntervalSince(start)
        let str = timeFormatter.string(from: duration)
        let milliseconds = String(format: "%.2f", duration * 1000)
        print("\tin: ", str ?? "", "(\(milliseconds) ms)")
    }
    
    private static func getInputString(filename: String) throws -> String {
        guard let fileURL = Bundle.module
                .url(forResource: filename, withExtension: nil) else {
            preconditionFailure("Could not decode input data")
        }
        
        return try String(contentsOf: fileURL)
    }
}
