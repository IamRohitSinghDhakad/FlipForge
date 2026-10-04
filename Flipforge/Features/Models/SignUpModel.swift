//
//  SignUpModel.swift
//  Flipforge
//
//  Created by Rohit Singh Dhakad on 05/07/26.
//

import UIKit
import SwiftUI
import Foundation

struct SignupResponse: Codable {

    let result: SignupResult
    let message: String
    let status: Int
}

enum SignupResult: Codable {

    case user(SignupUser)
    case error(String)

    init(from decoder: Decoder) throws {

        let container = try decoder.singleValueContainer()

        if let user = try? container.decode(SignupUser.self) {
            self = .user(user)
            return
        }

        if let message = try? container.decode(String.self) {
            self = .error(message)
            return
        }

        throw DecodingError.typeMismatch(
            SignupResult.self,
            .init(
                codingPath: decoder.codingPath,
                debugDescription: "Invalid result type"
            )
        )
    }

    func encode(to encoder: Encoder) throws {

        var container = encoder.singleValueContainer()

        switch self {

        case .user(let user):
            try container.encode(user)

        case .error(let message):
            try container.encode(message)
        }
    }
}

struct SignupUser: Codable {

    @FlexibleString var userId: String
    @FlexibleString var name: String
    @FlexibleString var email: String
    @FlexibleString var userImage: String
    @FlexibleString var status: String

    enum CodingKeys: String, CodingKey {
        case userId = "user_id"
        case name
        case email
        case userImage = "user_image"
        case status
    }
}
