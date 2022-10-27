struct InitialisationPart2: Initialisation {
    private(set) var currentMask: Mask
    private(set) var memory: [Int: Int]
    
    init() {
        self.init(currentMask: .init(), memory: [:])
    }
    
    init(currentMask: Mask = .init(), memory: [Int : Int] = [:]) {
        self.currentMask = currentMask
        self.memory = memory
    }
    
    mutating func apply(instruction: Instruction) {
        switch instruction {
        case .write(let write):
            MaskApplicatorV2
                .apply(mask: currentMask, to: write.address)
                .forEach { address in
                    memory[address] = write.value
                }

        case .mask(let newMask):
            currentMask = newMask
        }
    }
}
