//
//  ProfileModel.swift
//  Flipforge
//
//  Created by Rohit Singh Dhakad on 03/07/26.
//

import Foundation
import Combine

struct ProfileResponse: Codable {
    let result: ProfileUser
    let message: String
    let status: Int
}

struct ProfileUser: Codable {

    let userId: String
    let type: String
    let createdBy: String
    let code: String

    let name: String
    let username: String
    let mobile: String

    let icard: String?

    let defaultVehicle: String
    let dob: String
    let gender: String

    let email: String
    let password: String

    let userImage: String

    let address: String
    let bio: String
    let lat: String
    let lng: String

    let status: String
    let deviceType: String
    let registerId: String

    let socialId: String?
    let zoneId: String

    let stripeCustomerId: String?
    let stripeDefaultCardId: String?

    let entryDate: String

    let aadharFront: String?
    let aadharBack: String?
    let panImage: String?

    enum CodingKeys: String, CodingKey {

        case userId = "user_id"
        case type
        case createdBy = "created_by"
        case code
        case name
        case username
        case mobile
        case icard
        case defaultVehicle = "default_vehicle"
        case dob
        case gender
        case email
        case password
        case userImage = "user_image"
        case address
        case bio
        case lat
        case lng
        case status
        case deviceType = "device_type"
        case registerId = "register_id"
        case socialId = "social_id"
        case zoneId = "zone_id"
        case stripeCustomerId = "stripe_customer_id"
        case stripeDefaultCardId = "stripe_default_card_id"
        case entryDate = "entrydt"
        case aadharFront = "aadhar_front"
        case aadharBack = "aadhar_back"
        case panImage = "pan_image"
    }
}
