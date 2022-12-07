var test = 0

struct Day7: Solution {
    static let day = 7
    
    let state: Folder
    
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
    
    static func parseInput(_ input: String) -> Folder {
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
                            return .directory($0[1])
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
    
    static func generateFileStructure(input: [Input]) -> Folder {
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
        
        return fileSystem
    }
}

struct Folder {
    let name: String
    var folders: [String: Folder] = [:]
    var files: [File] = []
}

extension Folder {
    mutating func updatePath(_ path: [String],
                    withContents contents: [ListedItem]) {
        guard path.count > 1 else {
            contents.forEach {
                switch $0 {
                case .directory(let name):
                    folders[name] = Folder(name: name)
                case .file(let name, let size):
                    files.append(File(name: name, size: size))
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

struct File {
    let name: String
    let size: Int
}

extension Folder {
    var size: Int {
        files.map(\.size).reduce(0, +) +
            folders.values.map(\.size).reduce(0, +)
    }
    
    var subdirectories: [(name: String, value: Int)] {
        [(name, size)] + folders.values.flatMap(\.subdirectories)
    }
}

enum Input: Equatable {
    case cd(String)
    case ls([ListedItem])
}

enum ListedItem: Equatable {
    case directory(String)
    case file(String, Int)
}
