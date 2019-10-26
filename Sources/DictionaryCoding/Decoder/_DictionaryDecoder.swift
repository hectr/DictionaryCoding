import Foundation

internal class _DictionaryDecoder : Decoder {
    // MARK: Properties
    /// The decoder's storage.
    internal var storage: _DictionaryDecodingStorage

    /// Options set on the top-level decoder.
    internal let options: DictionaryDecoder._Options

    /// The path to the current point in encoding.
    internal(set) public var codingPath: [CodingKey]

    /// Contextual user-provided information for use during encoding.
    public var userInfo: [CodingUserInfoKey : Any] {
        return self.options.userInfo
    }

    // MARK: - Initialization
    /// Initializes `self` with the given top-level container and options.
    internal init(referencing container: Any, at codingPath: [CodingKey] = [], options: DictionaryDecoder._Options) {
        self.storage = _DictionaryDecodingStorage()
        self.storage.push(container: container)
        self.codingPath = codingPath
        self.options = options
    }

    // MARK: - Decoder Methods
    public func container<Key>(keyedBy type: Key.Type) throws -> KeyedDecodingContainer<Key> {
        guard !(self.storage.topContainer is NSNull) else {
            throw buildValueNotFoundInKeyedContainerError(type: type,
                                                          debugDescription: "Cannot get keyed decoding container -- found null value instead.")
        }

        guard let topContainer = self.storage.topContainer as? [String : Any] else {
            throw DecodingError._typeMismatch(at: self.codingPath, expectation: [String : Any].self, reality: self.storage.topContainer)
        }

        let container = DictionaryCodingKeyedDecodingContainer<Key>(referencing: self, wrapping: topContainer)
        return KeyedDecodingContainer(container)
    }

    public func unkeyedContainer() throws -> UnkeyedDecodingContainer {
        guard !(self.storage.topContainer is NSNull) else {
            throw buildValueNotFoundInUnkeyedContainerError(debugDescription: "Cannot get unkeyed decoding container -- found null value instead.")
        }

        guard let topContainer = self.storage.topContainer as? [Any] else {
            throw DecodingError._typeMismatch(at: self.codingPath, expectation: [Any].self, reality: self.storage.topContainer)
        }

        return _DictionaryUnkeyedDecodingContainer(referencing: self, wrapping: topContainer)
    }

    public func singleValueContainer() throws -> SingleValueDecodingContainer {
        return self
    }
}

// MARK: - Error customization

extension _DictionaryDecoder {
    internal func buildDataCorruptedError(value: Any, type: Any.Type, debugDescription: String) -> DecodingError {
        let context = DecodingError.Context(
            codingPath: codingPath,
            debugDescription: debugDescription,
            underlyingError: ErrorReason.dataCorrupted(value: value, type: type)
        )
        return DecodingError.dataCorrupted(context)
    }

    internal func buildValueNotFoundError(type: Any.Type, debugDescription: String) -> DecodingError {
        let context = DecodingError.Context(
            codingPath: codingPath,
            debugDescription: debugDescription,
            underlyingError: nil
        )
        return DecodingError.valueNotFound(type, context)
    }

    internal func buildValueNotFoundInKeyedContainerError<Key: CodingKey>(type: Key.Type, debugDescription: String) -> DecodingError {
        let context = DecodingError.Context(
            codingPath: codingPath,
            debugDescription: debugDescription,
            underlyingError: ErrorReason.valueNotFoundInKeyedContainer(type: type)
        )
        return DecodingError.valueNotFound(KeyedDecodingContainer<Key>.self, context)
    }

    internal func buildValueNotFoundInUnkeyedContainerError(debugDescription: String) -> DecodingError {
        let context = DecodingError.Context(
            codingPath: codingPath,
            debugDescription: debugDescription,
            underlyingError: nil
        )
        return DecodingError.valueNotFound(UnkeyedDecodingContainer.self, context)
    }
}
