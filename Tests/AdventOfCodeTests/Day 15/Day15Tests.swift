import XCTest
@testable import AdventOfCode

final class Day15Tests: XCTestCase, SolutionTest {
    typealias SUT = Day15
    
    func testPartOne() throws {
        try XCTAssertEqual(sut.calculatePartOne(), 2028)
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(sut.calculatePartTwo(), 0)
    }
}

extension Day15Tests {
    func testParsing() throws {
        XCTAssertEqual(
            try sut.map.values.map { $0.map(\.rawValue) },
            [
                ["#", "#", "#", "#", "#", "#", "#", "#"],
                ["#", ".", ".", "O", ".", "O", ".", "#"],
                ["#", "#", "@", ".", "O", ".", ".", "#"],
                ["#", ".", ".", ".", "O", ".", ".", "#"],
                ["#", ".", "#", ".", "O", ".", ".", "#"],
                ["#", ".", ".", ".", "O", ".", ".", "#"],
                ["#", ".", ".", ".", ".", ".", ".", "#"],
                ["#", "#", "#", "#", "#", "#", "#", "#"]
            ]
        )

        XCTAssertEqual(try sut.moves, [
            .left, .up, .up, .right, .right, .right, .down,
            .down, .left, .down, .right, .right, .down, .left, .left
        ])
    }

    func testCalculateGPSCoodinates() throws {
        let map = Grid(string: """
        ##########
        #.O.O.OOO#
        #........#
        #OO......#
        #OO@.....#
        #O#.....O#
        #O.....OO#
        #O.....OO#
        #OO....OO#
        ##########
        """, mapping: FactoryContents.init)

        XCTAssertEqual(try sut.calculateGPSCoodinates(for: map), 10092)
    }

    func testMakeMoveLeft() throws {
        let moveOne = try sut.makeMove(.left, grid: sut.map)
        XCTAssertEqual(try sut.map, moveOne)
    }

    func testMakeMoveUp() throws {
        let moveTwo = try sut.makeMove(.up, grid: sut.map)
        let expectedResult = Grid(
            string: """
            ########
            #.@O.O.#
            ##..O..#
            #...O..#
            #.#.O..#
            #...O..#
            #......#
            ########
            """,
            mapping: FactoryContents.init
        )

        XCTAssertEqual(moveTwo, expectedResult)
    }

    func testMakeMoveIntoBox() throws {
        let moveTwo = try sut.makeMove(.right, grid: Grid(string: """
        ########
        #.@O.O.#
        ##..O..#
        #...O..#
        #.#.O..#
        #...O..#
        #......#
        ########
        """, mapping: FactoryContents.init))

        let expectedResult = Grid(
            string: """
            ########
            #..@OO.#
            ##..O..#
            #...O..#
            #.#.O..#
            #...O..#
            #......#
            ########
            """,
            mapping: FactoryContents.init
        )

        XCTAssertEqual(moveTwo, expectedResult)
    }

    func testMakeMoveIntoMultipleBoxes() throws {
        let moveTwo = try sut.makeMove(.right, grid: Grid(string: """
        ########
        #..@OO.#
        ##..O..#
        #...O..#
        #.#.O..#
        #...O..#
        #......#
        ########
        """, mapping: FactoryContents.init))

        let expectedResult = Grid(
            string: """
            ########
            #...@OO#
            ##..O..#
            #...O..#
            #.#.O..#
            #...O..#
            #......#
            ########
            """,
            mapping: FactoryContents.init
        )

        XCTAssertEqual(moveTwo, expectedResult)
    }

    func testMakeMoveIntoWallWithBoxes() throws {
        let grid = Grid(string: """
        ########
        #...@OO#
        ##..O..#
        #...O..#
        #.#.O..#
        #...O..#
        #......#
        ########
        """, mapping: FactoryContents.init)

        let moveTwo = try sut.makeMove(.right, grid: grid)

        XCTAssertEqual(moveTwo, grid)
    }

    func testMakeMoves() throws {
        let finalState = try sut.makeMoves(sut.moves, on: sut.map)

        let expectedResult = Grid(
            string: """
            ########
            #....OO#
            ##.....#
            #.....O#
            #.#O@..#
            #...O..#
            #...O..#
            ########
            """,
            mapping: FactoryContents.init
        )

        XCTAssertEqual(finalState, expectedResult)
    }

    func testLargerExample() {
        let sut = SUT(input: """
        ##########
        #..O..O.O#
        #......O.#
        #.OO..O.O#
        #..O@..O.#
        #O#..O...#
        #O..O..O.#
        #.OO.O.OO#
        #....O...#
        ##########

        <vv>^<v^>v>^vv^v>v<>v^v<v<^vv<<<^><<><>>v<vvv<>^v^>^<<<><<v<<<v^vv^v>^
        vvv<<^>^v^^><<>>><>^<<><^vv^^<>vvv<>><^^v>^>vv<>v<<<<v<^v>^<^^>>>^<v<v
        ><>vv>v^v^<>><>>>><^^>vv>v<^^^>>v^v^<^^>v^^>v^<^v>v<>>v^v^<v>v^^<^^vv<
        <<v<^>>^^^^>>>v^<>vvv^><v<<<>^^^vv^<vvv>^>v<^^^^v<>^>vvvv><>>v^<<^^^^^
        ^><^><>>><>^^<<^^v>>><^<v>^<vv>>v>>>^v><>^v><<<<v>>v<v<v>vvv>^<><<>^><
        ^>><>^v<><^vvv<^^<><v<<<<<><^v<<<><<<^^<v<^^^><^>>^<v^><<<^>>^v<v^v<v^
        >^>>^v>vv>^<<^v<>><<><<v<<v><>v<^vv<<<>^^v^>^^>>><<^v>>v^v><^^>>^<>vv^
        <><^^>^^^<><vvvvv^v<v<<>^v<v>v<<^><<><<><<<^^<<<^<<>><<><^^^>^^<>^>v<>
        ^^>vv<^v^v<vv>^<><v<^v>^^^>>>^^vvv^>vvv<>>>^<^>>>>>^<<^v>^vvv<>^<><<v>
        v^^>>><<^^<>>^v^<v^vv<>v^<<>^<^v^v><^<<<><<^<v><v<>vv>>v><v^<vv<>v^<<^
        """)

        XCTAssertEqual(sut.calculatePartOne(), 10092)
    }
}
