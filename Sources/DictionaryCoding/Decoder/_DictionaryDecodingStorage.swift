import Foundation

internal struct _DictionaryDecodingStorage {
    // MARK: Properties
    /// The container stack.
    /// Elements may be any one of the Dictionary types (NSNull, NSNumber, String, Array, [String : Any]).
    private(set) fileprivate var containers: [Any] = []

    // MARK: - Initialization
    /// Initializes `self` with no containers.
    internal init() {}

    // MARK: - Modifying the Stack
    internal var count: Int {
        return self.containers.count
    }

    internal var topContainer: Any {
        precondition(self.containers.count > 0, "Empty container stack.")
        return self.containers.last!
    }

    internal mutating func push(container: Any) {
        self.containers.append(container)
    }

    internal mutating func popContainer() {
        precondition(self.containers.count > 0, "Empty container stack.")
        self.containers.removeLast()
    }
}
