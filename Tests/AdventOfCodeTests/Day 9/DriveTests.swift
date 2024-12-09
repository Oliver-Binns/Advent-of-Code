@testable import AdventOfCode
import Testing

struct DriveTests {
    @Test
    func testRemap() async throws {
        let sut: Drive = [
            .init(usage: .used(fileID: 0), size: 1),
            .init(usage: .free, size: 2),
            .init(usage: .used(fileID: 1), size: 3),
            .init(usage: .free, size: 4),
            .init(usage: .used(fileID: 2), size: 5),
        ]

        #expect(
            sut.remap() ==
            [
                .init(usage: .used(fileID: 0), size: 1),
                .init(usage: .used(fileID: 2), size: 2),
                .init(usage: .used(fileID: 1), size: 3),
                .init(usage: .used(fileID: 2), size: 3),
                .init(usage: .free, size: 1),
                .init(usage: .free, size: 2),
                .init(usage: .free, size: 3),
            ]
        )
    }

    @Test
    func testRemapWithFragmentationPrevention() async throws {
        let sut: Drive = [
            .init(usage: .used(fileID: 0), size: 1),
            .init(usage: .free, size: 2),
            .init(usage: .used(fileID: 1), size: 3),
            .init(usage: .free, size: 4),
            .init(usage: .used(fileID: 2), size: 5),
        ]

        #expect(
            sut.remap(preventFragmentation: true) ==
            [
                .init(usage: .used(fileID: 0), size: 1),
                .init(usage: .free, size: 2),
                .init(usage: .used(fileID: 1), size: 3),
                .init(usage: .free, size: 4),
                .init(usage: .used(fileID: 2), size: 5),
            ]
        )
    }
}
