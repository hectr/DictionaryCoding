import Foundation

extension DecodingError.Context {
    public var type: Any.Type? {
        return (underlyingError as? ErrorReason)?.type
    }
}
