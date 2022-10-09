import Foundation

struct Day1 {
    let day = 1
    let numbers: [Int]
    
    init(input: String) {
        self.numbers = input
            .split(whereSeparator: { $0.isWhitespace })
            .map(String.init)
            .compactMap(Int.init)
            .sorted()
    }
}

extension Day1: Solution {
    func calculatePartOne() -> String {
        
        for value in numbers {
            var index = 0
            while index < numbers.count {
                index += 1

                let sum = numbers[index] + value
                if sum == 2020 {
                    return (numbers[index] * value).description
                } else if sum > 2020 {
                    break
                }
            }
        }
        
        return ""
    }
}

extension Day1 {
    func calculatePartTwo() -> String {
        for value in numbers {
            var indexA = 1
            while indexA < numbers.count {
                var indexB = indexA + 1

                while indexB < numbers.count {
                    let sum = numbers[indexA] + numbers[indexB] + value

                    if sum == 2020 {
                        return (numbers[indexA] * numbers[indexB] * value).description
                    } else if sum > 2020 {
                        break
                    }

                    indexB += 1
                }

                indexA += 1
            }
        }
        
        return ""
    }
}
