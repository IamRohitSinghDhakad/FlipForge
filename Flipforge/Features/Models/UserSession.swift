//
//  UserSession.swift
//  Flipforge
//
//  Created by Rohit Singh Dhakad on 03/07/26.
//

import Foundation

final class UserSession {

    private enum Keys {
        static let userId = "user_id"
    }

    static var userId: String? {
        get {
            UserDefaults.standard.string(forKey: Keys.userId)
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.userId)
        }
    }

    static var isLoggedIn: Bool {
        userId != nil
    }

    static func logout() {
        UserDefaults.standard.removeObject(forKey: Keys.userId)
    }
}
