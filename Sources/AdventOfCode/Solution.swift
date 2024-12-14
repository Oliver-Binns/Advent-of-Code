protocol Solution {
    associatedtype Output1: CustomStringConvertible
    associatedtype Output2: CustomStringConvertible
    
    static var day: Int { get }
    init(input: String)
    func calculatePartOne() async -> Output1
    func calculatePartTwo() async -> Output2
}
