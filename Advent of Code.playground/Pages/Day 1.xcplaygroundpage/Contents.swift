import Cocoa
 
guard let fileURL = Bundle.main
        .url(forResource: "Expenses", withExtension: nil),
      let fileContents = try? String(contentsOf: fileURL) else {
    preconditionFailure("Could not decode input data")
}

let numbers = fileContents
    .split(whereSeparator: { $0.isWhitespace })
    .map(String.init)
    .compactMap(Int.init)
    .sorted()

// PART 1
numbers.first { value in
    var index = 0
    while index < numbers.count {
        index += 1

        let sum = numbers[index] + value
        if sum == 2020 {
            print("Challenge 1 Solution:",
                  "\(numbers[index]) * \(value) = \(numbers[index] * value)")
            return true
        } else if sum > 2020 {
            break
        }
    }
    return false
}

// PART 2
numbers.first { value in
    var indexA = 1
    while indexA < numbers.count {
        var indexB = indexA + 1

        while indexB < numbers.count {
            let sum = numbers[indexA] + numbers[indexB] + value

            if sum == 2020 {
                print("Challenge 2 Solution:",
                      "\(numbers[indexA]) * \(numbers[indexB]) * \(value) = \(numbers[indexA] * numbers[indexB] * value)")
                return true
            } else if sum > 2020 {
                break
            }

            indexB += 1
        }

        indexA += 1
    }

    return false
}
//: [Next](@next)
