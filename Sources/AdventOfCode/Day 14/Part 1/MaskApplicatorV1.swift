struct MaskApplicatorV1 {
    static func apply(mask: Mask, to value: Int) -> Int {
        let string = String(value, radix: 2)
        let maskedValue = mask.values.enumerated().map {
            switch $0.element {
            case 0: return "0"
            case 1: return "1"
            default:
                let offset = mask.values.count - $0.offset
                
                if offset > string.count {
                    return "0"
                } else {
                    let index = string.index(string.startIndex,
                                             offsetBy: string.count - offset)
                    return String(string[index])
                }
            }
        }.joined()
        
        return Int(maskedValue, radix: 2)!
    }
}
