import XCTest
@testable import AdventOfCode

final class Day17Tests: XCTestCase, SolutionTest {
    typealias SUT = Day17
    
    func testPartOne() throws {
        try XCTAssertEqual(
            sut.calculatePartOne(),
            "4,6,3,5,6,3,5,2,1,0"
        )
    }
    
    func testPartTwo() throws {
        try XCTAssertEqual(
            sut.calculatePartTwo(),
            0
        )
    }
}

extension Day17Tests {
    func testParsing() throws {
        try XCTAssertEqual(sut.initialState.registerA, 729)
        try XCTAssertEqual(sut.initialState.registerB, 0)
        try XCTAssertEqual(sut.initialState.registerC, 0)

        try XCTAssertEqual(sut.initialState.instructionPointer, 0)
        try XCTAssertEqual(sut.initialState.output, [])

        try XCTAssertEqual(sut.program, [0, 1, 5, 4, 3, 0])
    }

    func testOperandValue() {
        let computer = ComputerState(
            registerA: 15,
            registerB: 30,
            registerC: 45
        )

        XCTAssertEqual(computer.comboOperand(0), 0)
        XCTAssertEqual(computer.comboOperand(1), 1)
        XCTAssertEqual(computer.comboOperand(2), 2)
        XCTAssertEqual(computer.comboOperand(3), 3)

        XCTAssertEqual(computer.comboOperand(4), 15)
        XCTAssertEqual(computer.comboOperand(5), 30)
        XCTAssertEqual(computer.comboOperand(6), 45)
    }

    func testRunInstructionAdv() throws {
        let computer = try sut.initialState

        XCTAssertEqual(
            computer.runInstruction(opcode: .adv, operand: 2),
            ComputerState(registerA: 182, registerB: 0, registerC: 0, instructionPointer: 2)
        )
    }

    func testRunInstructionBxl() {
        let computer = ComputerState(registerA: 0, registerB: 2, registerC: 0)
        XCTAssertEqual(
            computer.runInstruction(opcode: .bxl, operand: 1),
            ComputerState(registerA: 0, registerB: 3, registerC: 0, instructionPointer: 2)
        )

        XCTAssertEqual(
            computer.runInstruction(opcode: .bxl, operand: 2),
            ComputerState(registerA: 0, registerB: 0, registerC: 0, instructionPointer: 2)
        )
    }

    func testRunInstructionBst() throws {
        let computer = try sut.initialState
        XCTAssertEqual(
            computer.runInstruction(opcode: .bst, operand: 3),
            ComputerState(registerA: 729, registerB: 3, registerC: 0, instructionPointer: 2)
        )
        XCTAssertEqual(
            computer.runInstruction(opcode: .bst, operand: 4),
            ComputerState(registerA: 729, registerB: 1, registerC: 0, instructionPointer: 2)
        )
    }

    func testRunInstructionJnzNoJump() {
        let computer = ComputerState(registerA: 0, registerB: 0, registerC: 0)
        XCTAssertEqual(
            computer.runInstruction(opcode: .jnz, operand: 4),
            ComputerState(registerA: 0, registerB: 0, registerC: 0, instructionPointer: 2)
        )
    }

    func testRunInstructionJnzWithJump() throws {
        let computer = try sut.initialState
        XCTAssertEqual(
            computer.runInstruction(opcode: .jnz, operand: 4),
            ComputerState(registerA: 729, registerB: 0, registerC: 0, instructionPointer: 4)
        )
    }

    func testRunInstructionBxc() throws {
        let computer = ComputerState(registerA: 729, registerB: 12, registerC: 5)
        XCTAssertEqual(
            computer.runInstruction(opcode: .bxc, operand: 3),
            ComputerState(registerA: 729, registerB: 9, registerC: 5, instructionPointer: 2)
        )
    }

    func testRunInstructionOut() throws {
        let computer = try sut.initialState
        XCTAssertEqual(
            computer.runInstruction(opcode: .out, operand: 0),
            ComputerState(registerA: 729, registerB: 0, registerC: 0,
                          instructionPointer: 2, output: [0])
        )

        XCTAssertEqual(
            computer.runInstruction(opcode: .out, operand: 4),
            ComputerState(registerA: 729, registerB: 0, registerC: 0,
                          instructionPointer: 2, output: [1])
        )
    }

    func testRunInstructionBdv() throws {
        let computer = try sut.initialState

        XCTAssertEqual(
            computer.runInstruction(opcode: .bdv, operand: 2),
            ComputerState(registerA: 729, registerB: 182, registerC: 0, instructionPointer: 2)
        )
    }

    func testRunInstructionCdv() throws {
        let computer = try sut.initialState

        XCTAssertEqual(
            computer.runInstruction(opcode: .cdv, operand: 2),
            ComputerState(registerA: 729, registerB: 0, registerC: 182, instructionPointer: 2)
        )
    }
}
