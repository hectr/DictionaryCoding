import Foundation

public enum ErrorReason: Swift.Error {
    case keyNotFound(type: Any.Type)
    case dataCorrupted(value: Any, type: Any.Type)
    case valueNotFound(dictionary: [String: Any]?)
    case valueNotFoundInKeyedContainer(type: Any.Type)
    case typeMismatch(unexpected: Any)
}
