//
//  ValidationManager.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 20/06/26.
//

import Foundation

enum ValidationResult {
    case success
    case failure(String)
}

enum ValidationManager {

    static func isValidEmail(_ email: String) -> Bool {

        let emailRegex =
        #"^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,64}$"#

        return NSPredicate(
            format: "SELF MATCHES %@",
            emailRegex
        ).evaluate(with: email)
    }

    static func isValidPassword(
        _ password: String
    ) -> Bool {

        let passwordRegex =
        #"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$"#

        return NSPredicate(
            format: "SELF MATCHES %@",
            passwordRegex
        ).evaluate(with: password)
    }
}
