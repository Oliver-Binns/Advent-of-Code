struct MaskApplicatorV2 {
    static func apply(mask: Mask, to value: Int) -> [Int] {
        print("apply")
        
        let string = String(value, radix: 2)
        let lengthDifference = mask.values.count - string.count
        let paddedString = String(repeating: "0", count: lengthDifference)
            + string
        
        let values = zip(mask.values,
            paddedString.map(String.init).compactMap(Int.init)).map {
            switch $0 {
            case 0: // remains unchanged
                return [$1]
            case 1: // overwritten with one
                return [1]
            default: // floating
                return [0, 1]
            }
        }
        
        print("values", values.count)
        
        return values.reduce([""]) { addresses, values in
            print("one", addresses)
            return addresses.flatMap { address in
                values.map {
                    address + String($0)
                }
            }
        }.compactMap { Int($0, radix: 2) }
    }
}
