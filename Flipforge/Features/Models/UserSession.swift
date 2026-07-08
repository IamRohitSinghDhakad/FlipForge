//
//  UserSession.swift
//  Flipforge
//
//  Created by Rohit Singh Dhakad on 03/07/26.
//

import Foundation

//
//  UserSession.swift
//  Flipforge
//
//  Created by Rohit Singh Dhakad on 03/07/26.
//

import Foundation

final class UserSession {

    // MARK: - Keys

    enum Key: String {

        case userId = "user_id"
        case userName = "user_name"
        case email = "email"
        case mobile = "mobile"
        case dateOfBirth = "date_of_birth"
        case profileImage = "profile_image"
        case paymentStatus = "payment_status"
        case isAutoLogin = "is_auto_login"
    }

    // MARK: - Generic Save

    static func save(
        _ value: Any?,
        for key: Key
    ) {

        UserDefaults.standard.set(
            value,
            forKey: key.rawValue
        )
    }

    // MARK: - Generic Fetch

    static func fetch<T>(
        _ key: Key,
        as type: T.Type = T.self
    ) -> T? {

        UserDefaults.standard.object(
            forKey: key.rawValue
        ) as? T
    }

    // MARK: - Remove

    static func remove(
        _ key: Key
    ) {

        UserDefaults.standard.removeObject(
            forKey: key.rawValue
        )
    }

    // MARK: - Common Properties

    static var userId: String {
        fetch(.userId) ?? ""
    }

    static var userName: String {
        fetch(.userName) ?? ""
    }

    static var email: String {
        fetch(.email) ?? ""
    }

    static var mobile: String {
        fetch(.mobile) ?? ""
    }

    static var dateOfBirth: String {
        fetch(.dateOfBirth) ?? ""
    }

    static var profileImage: String {
        fetch(.profileImage) ?? ""
    }

    static var paymentStatus: String {
        get {
            fetch(.paymentStatus) ?? "0"
        }
        set {
            save(newValue, for: .paymentStatus)
        }
    }
    
    

    static var isAutoLogin: Bool {
        fetch(.isAutoLogin) ?? false
    }

    static var isLoggedIn: Bool {

        !userId.isEmpty && isAutoLogin
    }

    // MARK: - Save Complete Session

    static func saveSession(
        userId: String,
        userName: String,
        email: String,
        mobile: String = "",
        dateOfBirth: String = "",
        profileImage: String = "",
        paymentStatus: String = "0"
    ) {

        save(userId, for: .userId)
        save(userName, for: .userName)
        save(email, for: .email)
        save(mobile, for: .mobile)
        save(dateOfBirth, for: .dateOfBirth)
        save(profileImage, for: .profileImage)
        save(paymentStatus, for: .paymentStatus)
        save(true, for: .isAutoLogin)
    }

    // MARK: - Logout

    static func logout() {

        for key in Key.allCases {

            remove(key)
        }
    }
}

extension UserSession.Key: CaseIterable { }
