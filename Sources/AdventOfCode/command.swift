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
