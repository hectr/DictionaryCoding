//===----------------------------------------------------------------------===//
//
// This source file is largely a copy of code from Swift.org open source project's
// files JSONEncoder.swift and Codeable.swift.
//
// Unfortunately those files do not expose the internal _JSONEncoder and
// _JSONDecoder classes, which are in fact dictionary encoder/decoders and
// precisely what we want...
//
// The original code is copyright (c) 2014 - 2017 Apple Inc. and the Swift project authors
// Licensed under Apache License v2.0 with Runtime Library Exception
//
// See https://swift.org/LICENSE.txt for license information
// See https://swift.org/CONTRIBUTORS.txt for the list of Swift project authors
//
// Modifications and additional code here is copyright (c) 2018 Sam Deane, and
// is licensed under the same terms.
//
//===----------------------------------------------------------------------===//

import Foundation


//===----------------------------------------------------------------------===//
// Dictionary Decoder
//===----------------------------------------------------------------------===//
/// `DictionaryDecoder` facilitates the decoding of Dictionary into semantic `Decodable` types.
open class DictionaryDecoder {
    // MARK: Options

    /// The strategy to use for non-Dictionary-conforming floating-point values (IEEE 754 infinity and NaN).
    public enum NonConformingFloatDecodingStrategy {
        /// Throw upon encountering non-conforming values. This is the default strategy.
        case `throw`
        
        /// Decode the values from the given representation strings.
        case convertFromString(positiveInfinity: String, negativeInfinity: String, nan: String)
    }
    
    /// The strategy to use when decoding missing keys.
    public enum MissingValueDecodingStrategy {
        /// Throw upon encountering missing values.
        case `throw`

        /// Attempt to use a default value when encountering missing values.
        /// The default value is read from the associated closure.
        case useDefault(defaults: (Any.Type) throws -> Any)
    }

    /// The strategy to use when values are missing.
    open var missingValueDecodingStrategy : MissingValueDecodingStrategy = .`throw`

    /// The strategy to use in decoding non-conforming numbers. Defaults to `.throw`.
    open var nonConformingFloatDecodingStrategy: NonConformingFloatDecodingStrategy = .throw

    /// Contextual user-provided information for use during decoding.
    open var userInfo: [CodingUserInfoKey : Any] = [:]
    
    /// Options set on the top-level encoder to pass down the decoding hierarchy.
    struct _Options {
        let missingValueDecodingStrategy : MissingValueDecodingStrategy
        let nonConformingFloatDecodingStrategy: NonConformingFloatDecodingStrategy
        let userInfo: [CodingUserInfoKey : Any]
    }
    
    /// The options set on the top-level decoder.
    fileprivate var options: _Options {
        return _Options(missingValueDecodingStrategy: missingValueDecodingStrategy,
                        nonConformingFloatDecodingStrategy: nonConformingFloatDecodingStrategy,
                        userInfo: userInfo)
    }
    
    // MARK: - Constructing a Dictionary Decoder
    /// Initializes `self` with default strategies.
    public init() {}
    
    // MARK: - Decoding Values
    
    /// Decodes a top-level value of the given type from the given Dictionary representation.
    ///
    /// - parameter type: The type of the value to decode.
    /// - parameter data: The data to decode from.
    /// - returns: A value of the requested type.
    /// - throws: `DecodingError.dataCorrupted` if values requested from the payload are corrupted, or if the given data is not valid Dictionary.
    /// - throws: An error if any value throws an error during decoding.
    open func decode<T : Decodable>(_ type: T.Type, from dictionary: NSDictionary) throws -> T {
        let decoder = _DictionaryDecoder(referencing: dictionary, options: self.options)
        guard let value = try decoder.unbox(dictionary, as: type) else {
            throw buildValueNotFoundError(type: type,
                                          dictionary: dictionary as? [String: Any],
                                          debugDescription: "The given data did not contain a top-level value.")
        }
        
        return value
    }
    
    /// Decodes a top-level value of the given type from the given Dictionary representation.
    ///
    /// - parameter type: The type of the value to decode.
    /// - parameter data: The data to decode from.
    /// - returns: A value of the requested type.
    /// - throws: `DecodingError.dataCorrupted` if values requested from the payload are corrupted, or if the given data is not valid Dictionary.
    /// - throws: An error if any value throws an error during decoding.
    open func decode<T : Decodable>(_ type: T.Type, from dictionary: [String:Any]) throws -> T {
        let decoder = _DictionaryDecoder(referencing: dictionary, options: self.options)
        guard let value = try decoder.unbox(dictionary, as: type) else {
            throw buildValueNotFoundError(type: type,
                                          dictionary: dictionary,
                                          debugDescription: "The given data did not contain a top-level value.")
        }
        
        return value
    }
    
}

// MARK: - Error customization

extension DictionaryDecoder {
    internal func buildValueNotFoundError(type: Any.Type, dictionary: [String: Any]?, debugDescription: String) -> DecodingError {
        let context = DecodingError.Context(
            codingPath: [],
            debugDescription: debugDescription,
            underlyingError: ErrorReason.valueNotFound(dictionary: dictionary)
        )
        return DecodingError.valueNotFound(type, context)
    }
}
