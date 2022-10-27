import Foundation

@main
struct Runner {
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
        print("\tPart One: \(solution.calculatePartOne())")
        print("\tPart Two: \(solution.calculatePartTwo())")
        print("\n")
    }
    
    private static func getInputString(filename: String) throws -> String {
        guard let fileURL = Bundle.module
                .url(forResource: filename, withExtension: nil) else {
            preconditionFailure("Could not decode input data")
        }
        
        return try String(contentsOf: fileURL)
    }
}
