struct InitialisationPart1: Initialisation {
    private(set) var currentMask: Mask
    private(set) var memory: [Int: Int]
    
    init() {
        self.init(currentMask: .init(), memory: [:])
    }
    
    init(currentMask: Mask = .init(),
         memory: [Int : Int] = [:]) {
        self.currentMask = currentMask
        self.memory = memory
    }
    
    mutating func apply(instruction: Instruction) {
        switch instruction {
        case .write(let write):
            memory[write.address] = MaskApplicatorV1
                .apply(mask: currentMask, to: write.value)

        case .mask(let newMask):
            currentMask = newMask
        }
    }
}
