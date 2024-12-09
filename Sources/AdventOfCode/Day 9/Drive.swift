struct Drive: Equatable {
    let blocks: [Block]

    var checksum: Int {
        blocks
            .flatMap(\.values)
            .enumerated()
            .map(*)
            .reduce(0, +)
    }

    init(input: String) {
        blocks = input
            .map(Character.init)
            .compactMap(String.init)
            .compactMap(Int.init)
            .enumerated()
            .map { id, character in
                Block(
                    usage: id.isEven ? .used(fileID: id / 2) : .free,
                    size: character
                )
            }
    }

    init(blocks: [Block]) {
        self.blocks = blocks
    }

    func remap(preventFragmentation: Bool = false) -> Drive {
        var blocks = self.blocks
        var minSize = 1
        // max file size  that can be represented by single digit
        let maxSize = 9

        while minSize <= maxSize {
            // find first available space to be filled
            guard let freeSpaceIndex = blocks.findFreeSpace(atLeast: minSize) else {
                // no spaces to fill - we're done here!
                break
            }
            let freeSpace = blocks[freeSpaceIndex]
            // find last available file to move
            guard let fileIndex = blocks
                .findLastFile(atMost: preventFragmentation ? freeSpace.size : .max) else {
                // no files of this size to move...
                // we're done here!
                continue
            }

            guard freeSpaceIndex < fileIndex else {
                // files must be moved to earlier position
                guard preventFragmentation else { break }
                // - try subsequent free blocks instead
                minSize += 1
                continue
            }

            let file = blocks[fileIndex]
            guard case .used(let fileID) = file.usage else {
                preconditionFailure("File Index must be a file")
            }

            // put file in the free space:
            blocks[freeSpaceIndex] = Block(
                usage: .used(fileID: fileID),
                size: min(file.size, freeSpace.size)
            )

            let remainingSpace = freeSpace.size - file.size
            // clear up the file that has been copied
            blocks[fileIndex] = Block(
                usage: .free,
                size: min(freeSpace.size, file.size)
            )
            // if file hasn't _all_ moved
            // then add remaining bytes
            if file.size > freeSpace.size {
                blocks.insert(
                    Block(
                        usage: .used(fileID: fileID),
                        size: file.size - freeSpace.size
                    ),
                    at: fileIndex + 1
                )
            }


            if remainingSpace > 0 {
                blocks.insert(
                    Block(usage: .free, size: remainingSpace),
                    at: freeSpaceIndex + 1
                )
            }
        }

        return Drive(blocks: blocks)
    }
}

extension Drive: ExpressibleByArrayLiteral {
    init(arrayLiteral blocks: Block...) {
        self.blocks = blocks
    }
}
