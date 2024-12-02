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
    
    static func main() throws {
        try [
            Day1.self,
            Day2.self,
            Day3.self,
            Day4.self,
            Day5.self,
            Day6.self,
            Day7.self,
            Day8.self,
            Day9.self,
            Day10.self,
            Day11.self,
            Day12.self,
            Day13.self,
            Day14.self,
            Day15.self,
            Day16.self,
            Day17.self,
            Day18.self,
            Day19.self,
            Day20.self,
            Day21.self,
            Day22.self,
            Day23.self,
            Day24.self,
            Day25.self
        ].forEach { day in
            try runDay(day)
        }
    }
    
    private static func runDay(_ day: any Solution.Type) throws {
        let inputString = try getInputString(filename: "Day\(day.day).input")
        let solution = day.init(input: inputString)
        
        print("Day \(day.day)")
        
        run(note: "Part One",
            calculate: solution.calculatePartOne)
        run(note: "Part Two",
            calculate: solution.calculatePartTwo)
        print("\n")
    }
    
    static func run(
        note: String,
        calculate: () -> CustomStringConvertible
    ) {
        let start = Date()
        print("\t\(note): ", calculate())
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
