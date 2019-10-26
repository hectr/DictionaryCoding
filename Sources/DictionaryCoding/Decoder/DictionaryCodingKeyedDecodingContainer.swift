import Foundation

// MARK: Decoding Containers
internal struct DictionaryCodingKeyedDecodingContainer<K : CodingKey> : KeyedDecodingContainerProtocol {
    typealias Key = K

    // MARK: Properties
    /// A reference to the decoder we're reading from.
    private let decoder: _DictionaryDecoder

    /// A reference to the container we're reading from.
    private let container: [String : Any]

    /// The path of coding keys taken to get to this point in decoding.
    private(set) public var codingPath: [CodingKey]

    // MARK: - Initialization
    /// Initializes `self` by referencing the given decoder and container.
    internal init(referencing decoder: _DictionaryDecoder, wrapping container: [String : Any]) {
        self.decoder = decoder
        self.container = container
        self.codingPath = decoder.codingPath
    }

    // MARK: - KeyedDecodingContainerProtocol Methods
    public var allKeys: [Key] {
        #if swift(>=4.1)
        return self.container.keys.compactMap { Key(stringValue: $0) }
        #else
        return self.container.keys.flatMap { Key(stringValue: $0) }
        #endif
    }

    public func contains(_ key: Key) -> Bool {
        return self.container[key.stringValue] != nil
    }

    internal func notFoundError(key: Key, type: Any.Type?) -> Swift.Error {
        if let type = type {
            return buildKeyNotFoundError(key: key,
                                         type: type,
                                         debugDescription: "No value associated with key \(_errorDescription(of: key)).")
        } else {
            return buildKeyNotFoundDecodingNilError(key: key,
                                                    debugDescription: "No value associated with key \(_errorDescription(of: key)).")
        }
    }

    internal func nullFoundError<T>(type: T.Type, key: Key) -> DecodingError {
        return buildKeyNotFoundError(key: key,
                                     type: type,
                                     debugDescription: "Expected \(type) value but found null instead.")
    }

    private func _errorDescription(of key: CodingKey) -> String {
        // just report the converted string
        return "\(key) (\"\(key.stringValue)\")"
    }

    public func decodeNil(forKey key: Key) throws -> Bool {
        guard let entry = self.container[key.stringValue] else {
            throw notFoundError(key: key, type: nil)
        }

        return entry is NSNull
    }

    internal func decode<T : Decodable>(_ type: T.Type, forKey key: Key) throws -> T {
        guard let entry = self.container[key.stringValue] else {
            switch (decoder.options.missingValueDecodingStrategy) {
            case let .useDefault(defaults):
                if let def = try defaults(type) as? T {
                    return def
                }
                default:
                    break
            }

            throw notFoundError(key: key, type: type)
        }

        self.decoder.codingPath.append(key)
        defer { self.decoder.codingPath.removeLast() }

        guard let value = try self.decoder.unbox(entry, as: type) else {
            throw nullFoundError(type: type, key: key)
        }

        return value
    }

    public func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type, forKey key: Key) throws -> KeyedDecodingContainer<NestedKey> {
        self.decoder.codingPath.append(key)
        defer { self.decoder.codingPath.removeLast() }

        guard let value = self.container[key.stringValue] else {
            throw buildKeyNotFoundError(key: key,
                                        type: type,
                                        debugDescription: "Cannot get \(KeyedDecodingContainer<NestedKey>.self) -- no value found for key \(_errorDescription(of: key))")
        }

        guard let dictionary = value as? [String : Any] else {
            throw DecodingError._typeMismatch(at: self.codingPath, expectation: [String : Any].self, reality: value)
        }

        let container = DictionaryCodingKeyedDecodingContainer<NestedKey>(referencing: self.decoder, wrapping: dictionary)
        return KeyedDecodingContainer(container)
    }

    public func nestedUnkeyedContainer(forKey key: Key) throws -> UnkeyedDecodingContainer {
        self.decoder.codingPath.append(key)
        defer { self.decoder.codingPath.removeLast() }

        guard let value = self.container[key.stringValue] else {
            throw buildKeyNotFoundError(key: key,
                                        type: KeyedDecodingContainer<Key>.self,
                                        debugDescription:  "Cannot get UnkeyedDecodingContainer -- no value found for key \(_errorDescription(of: key))")
        }

        guard let array = value as? [Any] else {
            throw DecodingError._typeMismatch(at: self.codingPath, expectation: [Any].self, reality: value)
        }

        return _DictionaryUnkeyedDecodingContainer(referencing: self.decoder, wrapping: array)
    }

    private func _superDecoder(forKey key: CodingKey) throws -> Decoder {
        self.decoder.codingPath.append(key)
        defer { self.decoder.codingPath.removeLast() }

        let value: Any = self.container[key.stringValue] ?? NSNull()
        return _DictionaryDecoder(referencing: value, at: self.decoder.codingPath, options: self.decoder.options)
    }

    public func superDecoder() throws -> Decoder {
        return try _superDecoder(forKey: DictionaryCodingKey.super)
    }

    public func superDecoder(forKey key: Key) throws -> Decoder {
        return try _superDecoder(forKey: key)
    }
}

// MARK: - Error customization

extension DictionaryCodingKeyedDecodingContainer {
    internal func buildKeyNotFoundError(key: Key, type: Any.Type, debugDescription: String) -> DecodingError {
        let context = DecodingError.Context(
            codingPath: self.decoder.codingPath,
            debugDescription: debugDescription,
            underlyingError: ErrorReason.keyNotFound(type: type)
        )
        return DecodingError.keyNotFound(key, context)
    }

    internal func buildKeyNotFoundDecodingNilError(key: Key, debugDescription: String) -> DecodingError {
        let context = DecodingError.Context(
            codingPath: self.decoder.codingPath,
            debugDescription: debugDescription,
            underlyingError: nil
        )
        return DecodingError.keyNotFound(key, context)
    }
}
