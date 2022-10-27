protocol Solution {
    associatedtype Output1: CustomStringConvertible
    associatedtype Output2: CustomStringConvertible
    
    static var day: Int { get }
    init(input: String)
    func calculatePartOne() -> Output1
    func calculatePartTwo() -> Output2
}
