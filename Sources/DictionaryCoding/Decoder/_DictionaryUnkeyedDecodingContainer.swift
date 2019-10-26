import Foundation

internal struct _DictionaryUnkeyedDecodingContainer : UnkeyedDecodingContainer {
    // MARK: Properties
    /// A reference to the decoder we're reading from.
    private let decoder: _DictionaryDecoder

    /// A reference to the container we're reading from.
    private let container: [Any]

    /// The path of coding keys taken to get to this point in decoding.
    private(set) public var codingPath: [CodingKey]

    /// The index of the element we're about to decode.
    private(set) public var currentIndex: Int

    // MARK: - Initialization
    /// Initializes `self` by referencing the given decoder and container.
    internal init(referencing decoder: _DictionaryDecoder, wrapping container: [Any]) {
        self.decoder = decoder
        self.container = container
        self.codingPath = decoder.codingPath
        self.currentIndex = 0
    }

    // MARK: - UnkeyedDecodingContainer Methods
    public var count: Int? {
        return self.container.count
    }

    public var isAtEnd: Bool {
        return self.currentIndex >= self.count!
    }

    public mutating func decodeNil() throws -> Bool {
        guard !self.isAtEnd else {
            throw buildValueNotFoundError(codingPath: self.decoder.codingPath + [DictionaryCodingKey(index: self.currentIndex)],
            type: Any?.self,
            debugDescription: "Unkeyed container is at end.")
        }

        if self.container[self.currentIndex] is NSNull {
            self.currentIndex += 1
            return true
        } else {
            return false
        }
    }

    public mutating func decode(_ type: Bool.Type) throws -> Bool {
        guard !self.isAtEnd else {
            throw buildValueNotFoundError(codingPath: self.decoder.codingPath + [DictionaryCodingKey(index: self.currentIndex)],
                                          type: type,
                                          debugDescription: "Unkeyed container is at end.")
        }

        self.decoder.codingPath.append(DictionaryCodingKey(index: self.currentIndex))
        defer { self.decoder.codingPath.removeLast() }

        guard let decoded = try self.decoder.unbox(self.container[self.currentIndex], as: Bool.self) else {
            throw buildValueNotFoundError(codingPath: self.decoder.codingPath + [DictionaryCodingKey(index: self.currentIndex)],
                                          type: type,
                                          debugDescription: "Expected \(type) but found null instead.")
        }

        self.currentIndex += 1
        return decoded
    }

    public mutating func decode(_ type: Int.Type) throws -> Int {
        guard !self.isAtEnd else {
            throw buildValueNotFoundError(codingPath: self.decoder.codingPath + [DictionaryCodingKey(index: self.currentIndex)],
                                          type: type,
                                          debugDescription: "Unkeyed container is at end.")
        }

        self.decoder.codingPath.append(DictionaryCodingKey(index: self.currentIndex))
        defer { self.decoder.codingPath.removeLast() }

        guard let decoded = try self.decoder.unbox(self.container[self.currentIndex], as: Int.self) else {
            throw buildValueNotFoundError(codingPath: self.decoder.codingPath + [DictionaryCodingKey(index: self.currentIndex)],
                                          type: type,
                                          debugDescription: "Expected \(type) but found null instead.")
        }

        self.currentIndex += 1
        return decoded
    }

    public mutating func decode(_ type: Int8.Type) throws -> Int8 {
        guard !self.isAtEnd else {
            throw buildValueNotFoundError(codingPath: self.decoder.codingPath + [DictionaryCodingKey(index: self.currentIndex)],
                                          type: type,
                                          debugDescription: "Unkeyed container is at end.")
        }

        self.decoder.codingPath.append(DictionaryCodingKey(index: self.currentIndex))
        defer { self.decoder.codingPath.removeLast() }

        guard let decoded = try self.decoder.unbox(self.container[self.currentIndex], as: Int8.self) else {
            throw buildValueNotFoundError(codingPath: self.decoder.codingPath + [DictionaryCodingKey(index: self.currentIndex)],
                                          type: type,
                                          debugDescription: "Expected \(type) but found null instead.")
        }

        self.currentIndex += 1
        return decoded
    }

    public mutating func decode(_ type: Int16.Type) throws -> Int16 {
        guard !self.isAtEnd else {
            throw buildValueNotFoundError(codingPath: self.decoder.codingPath + [DictionaryCodingKey(index: self.currentIndex)],
                                          type: type,
                                          debugDescription: "Unkeyed container is at end.")
        }

        self.decoder.codingPath.append(DictionaryCodingKey(index: self.currentIndex))
        defer { self.decoder.codingPath.removeLast() }

        guard let decoded = try self.decoder.unbox(self.container[self.currentIndex], as: Int16.self) else {
            throw buildValueNotFoundError(codingPath: self.decoder.codingPath + [DictionaryCodingKey(index: self.currentIndex)],
                                          type: type,
                                          debugDescription: "Expected \(type) but found null instead.")
        }

        self.currentIndex += 1
        return decoded
    }

    public mutating func decode(_ type: Int32.Type) throws -> Int32 {
        guard !self.isAtEnd else {
            throw buildValueNotFoundError(codingPath: self.decoder.codingPath + [DictionaryCodingKey(index: self.currentIndex)],
                                          type: type,
                                          debugDescription: "Unkeyed container is at end.")
        }

        self.decoder.codingPath.append(DictionaryCodingKey(index: self.currentIndex))
        defer { self.decoder.codingPath.removeLast() }

        guard let decoded = try self.decoder.unbox(self.container[self.currentIndex], as: Int32.self) else {
            throw buildValueNotFoundError(codingPath: self.decoder.codingPath + [DictionaryCodingKey(index: self.currentIndex)],
                                          type: type,
                                          debugDescription: "Expected \(type) but found null instead.")
        }

        self.currentIndex += 1
        return decoded
    }

    public mutating func decode(_ type: Int64.Type) throws -> Int64 {
        guard !self.isAtEnd else {
            throw buildValueNotFoundError(codingPath: self.decoder.codingPath + [DictionaryCodingKey(index: self.currentIndex)],
                                          type: type,
                                          debugDescription: "Unkeyed container is at end.")
        }

        self.decoder.codingPath.append(DictionaryCodingKey(index: self.currentIndex))
        defer { self.decoder.codingPath.removeLast() }

        guard let decoded = try self.decoder.unbox(self.container[self.currentIndex], as: Int64.self) else {
            throw buildValueNotFoundError(codingPath: self.decoder.codingPath + [DictionaryCodingKey(index: self.currentIndex)],
                                          type: type,
                                          debugDescription: "Expected \(type) but found null instead.")
        }

        self.currentIndex += 1
        return decoded
    }

    public mutating func decode(_ type: UInt.Type) throws -> UInt {
        guard !self.isAtEnd else {
            throw buildValueNotFoundError(codingPath: self.decoder.codingPath + [DictionaryCodingKey(index: self.currentIndex)],
                                          type: type,
                                          debugDescription: "Unkeyed container is at end.")
        }

        self.decoder.codingPath.append(DictionaryCodingKey(index: self.currentIndex))
        defer { self.decoder.codingPath.removeLast() }

        guard let decoded = try self.decoder.unbox(self.container[self.currentIndex], as: UInt.self) else {
            throw buildValueNotFoundError(codingPath: self.decoder.codingPath + [DictionaryCodingKey(index: self.currentIndex)],
                                          type: type,
                                          debugDescription: "Expected \(type) but found null instead.")
        }

        self.currentIndex += 1
        return decoded
    }

    public mutating func decode(_ type: UInt8.Type) throws -> UInt8 {
        guard !self.isAtEnd else {
            throw buildValueNotFoundError(codingPath: self.decoder.codingPath + [DictionaryCodingKey(index: self.currentIndex)],
                                          type: type,
                                          debugDescription: "Unkeyed container is at end.")
        }

        self.decoder.codingPath.append(DictionaryCodingKey(index: self.currentIndex))
        defer { self.decoder.codingPath.removeLast() }

        guard let decoded = try self.decoder.unbox(self.container[self.currentIndex], as: UInt8.self) else {
            throw buildValueNotFoundError(codingPath: self.decoder.codingPath + [DictionaryCodingKey(index: self.currentIndex)],
                                          type: type,
                                          debugDescription: "Expected \(type) but found null instead.")
        }

        self.currentIndex += 1
        return decoded
    }

    public mutating func decode(_ type: UInt16.Type) throws -> UInt16 {
        guard !self.isAtEnd else {
            throw buildValueNotFoundError(codingPath: self.decoder.codingPath + [DictionaryCodingKey(index: self.currentIndex)],
                                          type: type,
                                          debugDescription: "Unkeyed container is at end.")
        }

        self.decoder.codingPath.append(DictionaryCodingKey(index: self.currentIndex))
        defer { self.decoder.codingPath.removeLast() }

        guard let decoded = try self.decoder.unbox(self.container[self.currentIndex], as: UInt16.self) else {
            throw buildValueNotFoundError(codingPath: self.decoder.codingPath + [DictionaryCodingKey(index: self.currentIndex)],
                                          type: type,
                                          debugDescription: "Expected \(type) but found null instead.")
        }

        self.currentIndex += 1
        return decoded
    }

    public mutating func decode(_ type: UInt32.Type) throws -> UInt32 {
        guard !self.isAtEnd else {
            throw buildValueNotFoundError(codingPath: self.decoder.codingPath + [DictionaryCodingKey(index: self.currentIndex)],
                                          type: type,
                                          debugDescription: "Unkeyed container is at end.")
        }

        self.decoder.codingPath.append(DictionaryCodingKey(index: self.currentIndex))
        defer { self.decoder.codingPath.removeLast() }

        guard let decoded = try self.decoder.unbox(self.container[self.currentIndex], as: UInt32.self) else {
            throw buildValueNotFoundError(codingPath: self.decoder.codingPath + [DictionaryCodingKey(index: self.currentIndex)],
                                          type: type,
                                          debugDescription: "Expected \(type) but found null instead.")
        }

        self.currentIndex += 1
        return decoded
    }

    public mutating func decode(_ type: UInt64.Type) throws -> UInt64 {
        guard !self.isAtEnd else {
            throw buildValueNotFoundError(codingPath: self.decoder.codingPath + [DictionaryCodingKey(index: self.currentIndex)],
                                          type: type,
                                          debugDescription: "Unkeyed container is at end.")
        }

        self.decoder.codingPath.append(DictionaryCodingKey(index: self.currentIndex))
        defer { self.decoder.codingPath.removeLast() }

        guard let decoded = try self.decoder.unbox(self.container[self.currentIndex], as: UInt64.self) else {
            throw buildValueNotFoundError(codingPath: self.decoder.codingPath + [DictionaryCodingKey(index: self.currentIndex)],
                                          type: type,
                                          debugDescription: "Expected \(type) but found null instead.")
        }

        self.currentIndex += 1
        return decoded
    }

    public mutating func decode(_ type: Float.Type) throws -> Float {
        guard !self.isAtEnd else {
            throw buildValueNotFoundError(codingPath: self.decoder.codingPath + [DictionaryCodingKey(index: self.currentIndex)],
                                          type: type,
                                          debugDescription: "Unkeyed container is at end.")
        }

        self.decoder.codingPath.append(DictionaryCodingKey(index: self.currentIndex))
        defer { self.decoder.codingPath.removeLast() }

        guard let decoded = try self.decoder.unbox(self.container[self.currentIndex], as: Float.self) else {
            throw buildValueNotFoundError(codingPath: self.decoder.codingPath + [DictionaryCodingKey(index: self.currentIndex)],
                                          type: type,
                                          debugDescription: "Expected \(type) but found null instead.")
        }

        self.currentIndex += 1
        return decoded
    }

    public mutating func decode(_ type: Double.Type) throws -> Double {
        guard !self.isAtEnd else {
            throw buildValueNotFoundError(codingPath: self.decoder.codingPath + [DictionaryCodingKey(index: self.currentIndex)],
                                          type: type,
                                          debugDescription: "Unkeyed container is at end.")
        }

        self.decoder.codingPath.append(DictionaryCodingKey(index: self.currentIndex))
        defer { self.decoder.codingPath.removeLast() }

        guard let decoded = try self.decoder.unbox(self.container[self.currentIndex], as: Double.self) else {
            throw buildValueNotFoundError(codingPath: self.decoder.codingPath + [DictionaryCodingKey(index: self.currentIndex)],
                                          type: type,
                                          debugDescription: "Expected \(type) but found null instead.")
        }

        self.currentIndex += 1
        return decoded
    }

    public mutating func decode(_ type: String.Type) throws -> String {
        guard !self.isAtEnd else {
            throw buildValueNotFoundError(codingPath: self.decoder.codingPath + [DictionaryCodingKey(index: self.currentIndex)],
                                          type: type,
                                          debugDescription: "Unkeyed container is at end.")
        }

        self.decoder.codingPath.append(DictionaryCodingKey(index: self.currentIndex))
        defer { self.decoder.codingPath.removeLast() }

        guard let decoded = try self.decoder.unbox(self.container[self.currentIndex], as: String.self) else {
            throw buildValueNotFoundError(codingPath: self.decoder.codingPath + [DictionaryCodingKey(index: self.currentIndex)],
                                          type: type,
                                          debugDescription: "Expected \(type) but found null instead.")
        }

        self.currentIndex += 1
        return decoded
    }

    public mutating func decode<T : Decodable>(_ type: T.Type) throws -> T {
        guard !self.isAtEnd else {
            throw buildValueNotFoundError(codingPath: self.decoder.codingPath + [DictionaryCodingKey(index: self.currentIndex)],
                                          type: type,
                                          debugDescription: "Unkeyed container is at end.")
        }

        self.decoder.codingPath.append(DictionaryCodingKey(index: self.currentIndex))
        defer { self.decoder.codingPath.removeLast() }

        guard let decoded = try self.decoder.unbox(self.container[self.currentIndex], as: type) else {
            throw buildValueNotFoundError(codingPath: self.decoder.codingPath + [DictionaryCodingKey(index: self.currentIndex)],
                                          type: type,
                                          debugDescription: "Expected \(type) but found null instead.")
        }

        self.currentIndex += 1
        return decoded
    }

    public mutating func nestedContainer<NestedKey>(keyedBy type: NestedKey.Type) throws -> KeyedDecodingContainer<NestedKey> {
        self.decoder.codingPath.append(DictionaryCodingKey(index: self.currentIndex))
        defer { self.decoder.codingPath.removeLast() }

        guard !self.isAtEnd else {
            throw buildValueNotFoundError(codingPath: self.codingPath,
                                          type: KeyedDecodingContainer<NestedKey>.self,
                                          debugDescription: "Cannot get nested keyed container -- unkeyed container is at end.")
        }

        let value = self.container[self.currentIndex]
        guard !(value is NSNull) else {
            throw buildValueNotFoundError(codingPath: self.codingPath,
                                          type: KeyedDecodingContainer<NestedKey>.self,
                                          debugDescription: "Cannot get keyed decoding container -- found null value instead.")
        }

        guard let dictionary = value as? [String : Any] else {
            throw DecodingError._typeMismatch(at: self.codingPath, expectation: [String : Any].self, reality: value)
        }

        self.currentIndex += 1
        let container = DictionaryCodingKeyedDecodingContainer<NestedKey>(referencing: self.decoder, wrapping: dictionary)
        return KeyedDecodingContainer(container)
    }

    public mutating func nestedUnkeyedContainer() throws -> UnkeyedDecodingContainer {
        self.decoder.codingPath.append(DictionaryCodingKey(index: self.currentIndex))
        defer { self.decoder.codingPath.removeLast() }

        guard !self.isAtEnd else {
            throw buildValueNotFoundError(codingPath: self.codingPath,
                                          type: UnkeyedDecodingContainer.self,
                                          debugDescription: "Cannot get nested keyed container -- unkeyed container is at end.")
        }

        let value = self.container[self.currentIndex]
        guard !(value is NSNull) else {
            throw buildValueNotFoundError(codingPath: self.codingPath,
                                                     type: UnkeyedDecodingContainer.self,
                                                     debugDescription: "Cannot get keyed decoding container -- found null value instead.")
        }

        guard let array = value as? [Any] else {
            throw DecodingError._typeMismatch(at: self.codingPath, expectation: [Any].self, reality: value)
        }

        self.currentIndex += 1
        return _DictionaryUnkeyedDecodingContainer(referencing: self.decoder, wrapping: array)
    }

    public mutating func superDecoder() throws -> Decoder {
        self.decoder.codingPath.append(DictionaryCodingKey(index: self.currentIndex))
        defer { self.decoder.codingPath.removeLast() }

        guard !self.isAtEnd else {
            throw buildValueNotFoundError(codingPath: self.codingPath,
                                          type: Decoder.self,
                                          debugDescription: "Cannot get superDecoder() -- unkeyed container is at end.")
        }

        let value = self.container[self.currentIndex]
        self.currentIndex += 1
        return _DictionaryDecoder(referencing: value, at: self.decoder.codingPath, options: self.decoder.options)
    }
}

// MARK: - Error customization

extension _DictionaryUnkeyedDecodingContainer {
    internal func buildValueNotFoundError(codingPath: [CodingKey], type: Any.Type, debugDescription: String) -> DecodingError {
        let context = DecodingError.Context(
            codingPath: codingPath,
            debugDescription: debugDescription,
            underlyingError: nil
        )
        return DecodingError.valueNotFound(type, context)
    }
}
