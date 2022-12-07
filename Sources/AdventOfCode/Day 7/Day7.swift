var test = 0

struct Day7: Solution {
    static let day = 7
    
    let state: Output
    
    init(input: String) {
        state = Self.parseInput(input)
    }
    
    func calculatePartOne() -> Int {
        state.subdirectories
            .map(\.value)
            .filter { $0 <= 100_000 }
            .reduce(0, +)
    }
    
    func calculatePartTwo() -> Int {
        let totalSpace = 70000000
        let requiredSpace = 30000000
        let usedSpace = state.size
        let currentSpace = totalSpace - usedSpace
        let spaceToDelete = requiredSpace - currentSpace
        
        guard let directorySize = state
            .subdirectories
            .map(\.value)
            .sorted(by: <)
            .first(where: { value in
                value >= spaceToDelete
            }) else {
                preconditionFailure("No directory large enough to create required space")
            }
        
        return directorySize
    }
}

extension Day7 {
    static func structureRawInput(_ input: String) -> [[String]] {
        input
            .components(separatedBy: "$ ")
            .filter(!\.isEmpty)
            .map { $0
                .components(separatedBy: .newlines)
                .filter(!\.isEmpty)
            }
    }
    
    static func parseInput(_ input: String) -> Output {
        generateFileStructure(input: parseInput(structureRawInput(input)))
    }
    
    static func parseInput(_ input: [[String]]) -> [Input] {
        input.map { value in
            switch value.count {
            case 1: // change directory
                return .cd(
                    value[0].components(separatedBy: .whitespaces)[1]
                )
            default: // list directory
                return .ls(value
                    .suffix(from: 1)
                    .map {
                        $0.components(separatedBy: .whitespaces)
                    }
                    .map {
                        switch $0.first {
                        case "dir":
                            return .directory($0[1], [])
                        default:
                            guard let size = Int($0[0]) else {
                                preconditionFailure("File has invalid size")
                            }
                            return .file($0[1], size)
                        }
                    }
                )
            }
        }
    }
    
    static func generateFileStructure(input: [Input]) -> Output {
        var fileSystem = Folder(name: "/")
        var currentPath = [String]()
        
        for command in input {
            switch command {
            case .ls(let contents):
                fileSystem.updatePath(currentPath,
                                      withContents: contents)
            case .cd(".."):
                currentPath.removeLast()
            case .cd(let newDirectory):
                currentPath.append(newDirectory)
            }
        }
        
        return fileSystem.output
    }
}

struct Folder {
    let name: String
    var folders: [String: Folder] = [:]
    var files: [Output] = []
}

extension Folder {
    var output: Output {
        return .directory(name,
                          files + folders.compactMap { $0.value.output })
    }
    
    mutating func updatePath(_ path: [String],
                    withContents contents: [Output]) {
        guard path.count > 1 else {
            contents.forEach {
                switch $0 {
                case .directory(let name, _):
                    folders[name] = Folder(name: name)
                default:
                    files.append($0)
                }
            }
            return
        }
        
        let subdirectoryName = path[1]
        folders[subdirectoryName]?
            .updatePath(Array(path.suffix(from: 1)),
                        withContents: contents)
    }
}

enum Input: Equatable {
    case cd(String)
    case ls([Output])
}

enum Output: Equatable {
    case directory(String, [Output])
    case file(String, Int)
}

extension Output {
    var isFile: Bool {
        switch self {
        case .file:
            return true
        default:
            return false
        }
    }
    
    var name: String {
        switch self {
        case .file(let name, _):
            return name
        case .directory(let name, _):
            return name
        }
    }
}

extension Output {
    func toString(indent: Int = 0) -> String {
        let indentString = (0..<indent).map { _ in "\t" }.joined()
        
        switch self {
        case .directory(let name, let contents):
            return """
            \(indentString)- \(name) (dir)
            
            """ + contents
                .map { $0.toString(indent: indent + 1) }
                .joined()
        case .file(let name, let size):
            return """
            \(indentString)- \(name) (file, size=\(size))
            
            """
        }
       
    }
}

extension Output {
    var size: Int {
        switch self {
        case .file(_, let size):
            return size
        case .directory(_, let contents):
            return contents
                .map(\.size)
                .reduce(0, +)
        }
    }
    
    var subdirectories: [(name: String, value: Int)] {
        switch self {
        case .file:
            return []
        case .directory(let name, let contents):
            return [(name, size)] + contents.flatMap(\.subdirectories)
        }
    }
}
