import Foundation

public enum ErrorReason: Swift.Error {
    case keyNotFound(type: Any.Type)
    case dataCorrupted(value: Any, type: Any.Type)
    case valueNotFound(dictionary: [String: Any]?)
    case valueNotFoundInKeyedContainer(type: Any.Type)
    case typeMismatch(unexpected: Any)

    public var type: Any.Type? {
        switch self {
        case .keyNotFound(let type):
            return type
        case .dataCorrupted(_, let type):
            return type
        case .valueNotFound(_):
            return nil
        case .valueNotFoundInKeyedContainer(let type):
            return type
        case .typeMismatch(_):
            return nil
        }
    }
}
