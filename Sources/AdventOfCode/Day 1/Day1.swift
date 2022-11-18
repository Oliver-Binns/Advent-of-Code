struct Day1: Solution {
    static let day = 1
    
    let masses: [Int]
    
    /// Initialise your solution
    ///
    /// - parameters:
    ///   - input: Contents of the `Day1.input` file within the same folder as this source file
    init(input: String) {
        masses = input
            .components(separatedBy: .newlines)
            .compactMap(Int.init)
    }

    /// Return your answer to the main activity of the advent calendar
    ///
    /// If you need to, you can change the return type of this method to any type that conforms to `CustomStringConvertible`, i.e. `String`, `Float`, etc.
    func calculatePartOne() -> Int {
        masses
            .map(calculateFuel)
            .reduce(0, +)
    }

    /// Return your solution to the extension activity
    /// _ N.B. This is only unlocked when you have completed part one! _
    func calculatePartTwo() -> Int {
        masses
            .map(calculateFuelForFuel)
            .reduce(0, +)
    }
}

extension Day1 {
    func calculateFuel(mass: Int) -> Int {
        (mass / 3) - 2
    }
    
    // pass in 14
    // fuelRequired = 2
    // true: 2 + recursion(2) (2 + 2) = 4
    //      fuelRequired = -2
    //      return 0
    
    func calculateFuelForFuel(mass: Int) -> Int {
        let fuelRequired = calculateFuel(mass: mass)
        if fuelRequired > 0 {
            return fuelRequired + calculateFuelForFuel(mass: fuelRequired)
        }
        return 0
    }
}
