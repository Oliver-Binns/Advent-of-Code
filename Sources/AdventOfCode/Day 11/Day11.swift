import Algorithms

struct Day11: Solution {
    static let day = 11
    
    let monkeys: [Monkey]
    
    init(input: String) {
        monkeys = input
            .components(separatedBy: "\n\n")
            .compactMap(Monkey.init)
    }
    
    func calculatePartOne() -> Int {
        (0..<20).reduce(monkeys) { partialResult, _ in
            inspectItems(monkeys: partialResult)
        }
        .map(\.itemsInspected)
        .max(count: 2)
        .reduce(1, *)
    }
    
    func calculatePartTwo() -> Int {
        (0..<1).reduce(monkeys) { partialResult, _ in
            inspectItems(monkeys: partialResult, dividedBy: 1)
        }
        .map(\.itemsInspected)
        .max(count: 2)
        .reduce(1, *)
    }
    
    func inspectItems(monkeys: [Monkey], dividedBy: Int = 3) -> [Monkey] {
        var monkeys = monkeys
        
        for index in 0..<monkeys.count {
            while !monkeys[index].items.isEmpty {
                // multiply worry level:
                let item = monkeys[index].inspectItem()
                let worryLevel = monkeys[index].operation(item) / dividedBy
                let isDivisible = worryLevel % monkeys[index].test.divisibleBy == 0
                let passToIndex = isDivisible ? monkeys[index].test.ifTrue : monkeys[index].test.ifFalse
                
                monkeys[passToIndex].items.append(worryLevel)
            }
        }
        
        return monkeys
    }
}

struct Monkey {
    var itemsInspected: Int = 0
    var items: [Int]
    let operation: (Int) -> Int
    let test: Test
    
    init?(rawValue: String) {
        let lines = rawValue.components(separatedBy: .newlines)
        self.items = lines[1]
            .components(separatedBy: [" ", ","])
            .compactMap(Int.init)
        
        guard let operation = lines[2]
            .components(separatedBy: "=")
            .last?
            .components(separatedBy: .whitespaces)
            .filter(!\.isEmpty) else {
            preconditionFailure("Invalid operation format")
        }
        
        let op: (Int, Int) -> Int
        switch operation[1] {
        case "+": op = (+)
        case "*": op = (*)
        default: preconditionFailure("unexpected operation")
        }
        
        self.operation = { value in
            let lhs = Int(operation[0]) ?? value
            let rhs = Int(operation[2]) ?? value
            return op(lhs, rhs)
        }
        
        test = .init(rawValue: Array(lines[3...]))
    }
    
    init(items: [Int],
         operation: @escaping (Int) -> Int,
         test: Test) {
        self.items = items
        self.operation = operation
        self.test = test
    }
    
    mutating func inspectItem() -> Int {
        itemsInspected += 1
        return items.removeFirst()
    }
}

struct Test: Equatable {
    let divisibleBy: Int
    let ifTrue: Int
    let ifFalse: Int
    
    init(divisibleBy: Int,
         ifTrue: Int,
         ifFalse: Int) {
        self.divisibleBy = divisibleBy
        self.ifTrue = ifTrue
        self.ifFalse = ifFalse
    }
    
    init(rawValue: [String]) {
        let values = rawValue.compactMap {
            $0
                .components(separatedBy: .whitespaces)
                .compactMap(Int.init)
                .first
        }
        self.divisibleBy = values[0]
        self.ifTrue = values[1]
        self.ifFalse = values[2]
    }
}
