enum DriveUsage: Equatable {
    case free
    case used(fileID: Int)
}

extension DriveUsage: CustomStringConvertible {
    var description: String {
        switch self {
        case .free: return
            "."
        case .used(fileID: let fileID):
            return fileID.description
        }
    }
}
