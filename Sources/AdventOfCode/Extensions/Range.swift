import Foundation

extension Range where Bound == Int {
    init(start: Int, length: Int) {
        let end = start+length
        self = start..<end
    }
}
