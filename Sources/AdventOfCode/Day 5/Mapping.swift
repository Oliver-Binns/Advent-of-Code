struct Mapping: Equatable {
    let source: Range<Int>
    let destination: Range<Int>
    
    init(sourceStart: Int, destinationStart: Int, length: Int) {
        source = Range(start: sourceStart, length: length)
        destination = Range(start: destinationStart, length: length)
    }
    
    init(rawString: String) {
        let components = rawString
            .components(separatedBy: .whitespaces)
            .compactMap(Int.init)
        
        self.init(sourceStart: components[1],
                  destinationStart: components[0],
                  length: components[2])
    }
    
    func contains(item: Int) -> Bool {
        source.contains(item)
    }
    
    func contains(range: Range<Int>) -> Bool {
        source.overlaps(range)
    }
    
    func map(item: Int) -> Int {
        let offset = source.upperBound - item
        return destination.upperBound - offset
    }
    
    func map(range: Range<Int>) -> (Range<Int>?, Range<Int>, Range<Int>?) {
        let lower: Range<Int>? = if range.lowerBound < source.lowerBound {
            range.lowerBound..<source.lowerBound
        } else {
            nil
        }
        
        let mid = range.clamped(to: source)
        let midMapped = map(item: mid.lowerBound)..<map(item: mid.upperBound)
        
        let upper: Range<Int>? = if range.upperBound > source.upperBound {
            source.upperBound..<range.upperBound
        } else {
            nil
        }
        
        return (lower, midMapped, upper)
    }
}
