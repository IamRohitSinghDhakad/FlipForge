//
//  UserDefaultManager.swift
//  Flipforge
//
//  Created by Rohit Singh Dhakad on 03/07/26.
//

import Foundation

final class UserDefaultsManager {

    static let shared = UserDefaultsManager()

    private init() {}

    private enum Keys {
        static let userId = "user_id"
    }

    // MARK: - User Id

    var userId: String {
        get {
            UserDefaults.standard.string(forKey: Keys.userId) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: Keys.userId)
        }
    }

    var isLoggedIn: Bool {
        !userId.isEmpty
    }

    func logout() {
        UserDefaults.standard.removeObject(forKey: Keys.userId)
    }
}
