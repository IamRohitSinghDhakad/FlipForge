//
//  FlexibleString.swift
//  Flipforge
//
//  Created by Rohit Singh Dhakad on 03/07/26.
//

import Foundation

extension KeyedDecodingContainer {

    func decode(
        _ type: FlexibleString.Type,
        forKey key: Key
    ) throws -> FlexibleString {

        try decodeIfPresent(type, forKey: key) ?? FlexibleString()
    }
}

@propertyWrapper
struct FlexibleString: Codable, Hashable {

    var wrappedValue: String

    init(wrappedValue: String = "") {
        self.wrappedValue = wrappedValue
    }

    init(from decoder: Decoder) throws {

        let container = try decoder.singleValueContainer()

        if container.decodeNil() {
            wrappedValue = ""
        } else if let string = try? container.decode(String.self) {
            wrappedValue = string
        } else if let int = try? container.decode(Int.self) {
            wrappedValue = "\(int)"
        } else if let double = try? container.decode(Double.self) {
            wrappedValue = "\(double)"
        } else if let bool = try? container.decode(Bool.self) {
            wrappedValue = "\(bool)"
        } else {
            wrappedValue = ""
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedValue)
    }
}
