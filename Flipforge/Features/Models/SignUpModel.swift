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

    let result: SignupUser
    let message: String
    let status: Int
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
