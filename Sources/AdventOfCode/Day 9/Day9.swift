struct Day9: Solution {
    static let day = 9

    let drive: Drive

    init(input: String) {
        drive = Drive(input: input)
    }

    func calculatePartOne() -> Int {
        drive
            .remap()
            .checksum
    }
    
    func calculatePartTwo() -> Int {
        drive.remap(preventFragmentation: true).checksum
    }
}

extension Int {
    var isEven: Bool {
        self % 2 == 0
    }
}
