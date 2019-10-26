import Foundation

extension DecodingError {
    public var context: DecodingError.Context? {
        switch self {
        case .typeMismatch(_, let context):
            return context
        case .valueNotFound(_, let context):
            return context
        case .keyNotFound(_, let context):
            return context
        case .dataCorrupted(let context):
            return context
        @unknown default:
            return nil
        }
    }
}
