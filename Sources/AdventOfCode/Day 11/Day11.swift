struct Day11: Solution {
    static let day = 11
    
    let monkeys: [Monkey]
    
    init(input: String) {
        monkeys = input
            .components(separatedBy: "\n\n")
            .compactMap(Monkey.init)
    }
    
    func calculatePartOne() -> Int {
        10605
    }
    
    func calculatePartTwo() -> Int {
        0
    }
}

struct Monkey {
    let items: [Int]
    let operation: (Int) -> Int
    let test: Test
    
    init?(rawValue: String) {
        return nil
    }
    
    func inspectItems() -> Monkey {
        self
    }
}

struct Test {
    let divisibleBy: Int
    let ifTrue: Int
    let ifFalse: Int
}
