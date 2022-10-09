import Foundation

struct Day9: Solution {
    let day = 9
    let numbers: [Int]
    
    init(input: String) {
        numbers = input
            .split(whereSeparator: { $0.isWhitespace })
            .map(String.init)
            .compactMap(Int.init)
    }
    
    func calculatePartOne() -> String {
        calculatePartOne(preambleLength: 25).description
    }
    
    func calculatePartOne(preambleLength: Int) -> Int {
        for index in preambleLength..<numbers.count-1
        where !possibleValues(for: index, preambleLength: preambleLength).contains(numbers[index]) {
            return numbers[index]
        }
        return -1
    }
    
    func calculatePartTwo() -> String {
        calculatePartTwo(preambleLength: 25).description
    }
    
    func calculatePartTwo(preambleLength: Int) -> Int {
        let firstInvalidValue = calculatePartOne(preambleLength: preambleLength)
        guard let index = numbers.firstIndex(of: firstInvalidValue) else {
            return -1
        }
        
        for index in (0..<index).reversed() {
            for length in (0..<index).reversed() {
                let contiguous = previousNumbers(at: index, length: length)
                let sum = contiguous.reduce(0, +)
                
                if sum == firstInvalidValue,
                   let largest = contiguous.max(),
                   let smallest = contiguous.min() {
                    return largest + smallest
                }
            }
        }
        return -1
    }
}

extension Day9 {
    func previousNumbers(at index: Int, length: Int = 25) -> Set<Int> {
        Set(numbers[index-length..<index])
    }
    
    func possibleValues(for index: Int, preambleLength: Int = 25) -> Set<Int> {
        let preamble = previousNumbers(at: index, length: preambleLength)
        
        return Set(preamble.flatMap { valueOne in
            return preamble.compactMap { valueTwo in
                guard valueOne != valueTwo else { return nil }
                return valueOne + valueTwo
            }
        })
    }
}
