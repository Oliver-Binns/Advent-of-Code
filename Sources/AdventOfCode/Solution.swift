protocol Solution {
    associatedtype Output: CustomStringConvertible
    
    var day: Int { get }
    init(input: String)
    func calculatePartOne() -> Output
    func calculatePartTwo() -> Output
}
