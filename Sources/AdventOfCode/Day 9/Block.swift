struct Block: Equatable {
    let usage: DriveUsage
    let size: Int
}

extension Block: CustomStringConvertible {
    var description: String {
        (0..<size)
            .map { _ in usage.description }
            .joined()
    }

    var values: [Int] {
        (0..<size)
            .map { _ in
                switch usage {
                case .free:
                    return 0
                case .used(fileID: let fileID):
                    return fileID
                }
            }
    }
}

extension Array where Element == Block {
    func findFreeSpace(atLeast size: Int) -> Int? {
        firstIndex(where: { block in
            guard case .free = block.usage else {
                return false
            }
            return block.size >= size
        })
    }

    func findLastFile(atMost size: Int) -> Int? {
        lastIndex(where: { block in
            guard case .used = block.usage else {
                return false
            }
            return block.size <= size
        })
    }
}
