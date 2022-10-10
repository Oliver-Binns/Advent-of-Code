import Foundation

@main
struct Runner {
    static func main() throws {
        let days: [(class: any Solution.Type, input: String)] = [
            (Day1.self, "Expenses"),
            (Day2.self, "Passwords"),
            (Day3.self, "Map"),
            (Day4.self, "Documentation"),
            (Day5.self, "Seat Map"),
            (Day6.self, "Customs Forms"),
            (Day7.self, "Bag Restrictions"),
            (Day8.self, "Program Code"),
            (Day9.self, "Day9"),
            (Day10.self, "Day10"),
            (Day11.self, "Day11"),
            (Day12.self, "Day12"),
            (Day13.self, "Day13"),
            (Day14.self, "Day14"),
            (Day15.self, "Day15"),
            (Day16.self, "Day16"),
            (Day17.self, "Day17"),
            (Day18.self, "Day18"),
            (Day19.self, "Day19"),
            (Day20.self, "Day20"),
            (Day21.self, "Day21"),
            (Day22.self, "Day22"),
            (Day23.self, "Day23"),
            (Day24.self, "Day24"),
            (Day25.self, "Day25"),
        ]
        
        try days.map {
            try $0.class.init(input: getInputString(filename: $0.input))
        }.forEach {
            print("Day \($0.day)")
            print("\tPart One: \($0.calculatePartOne())")
            print("\tPart Two: \($0.calculatePartTwo())")
            print("\n")
        }
    }
    
    private static func getInputString(filename: String) throws -> String {
        guard let fileURL = Bundle.module
                .url(forResource: filename, withExtension: nil) else {
            preconditionFailure("Could not decode input data")
        }
        
        return try String(contentsOf: fileURL)
    }
}
