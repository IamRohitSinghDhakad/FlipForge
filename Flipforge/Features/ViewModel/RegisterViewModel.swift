//
//  RegisterViewModel.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 19/06/26.
//

import Foundation
import UIKit
import Combine

@MainActor
final class RegisterViewModel: BaseViewModel {

    @Published var fullName = ""
    @Published var email = ""
    @Published var password = ""
    @Published var confirmPassword = ""

    @Published var profileImage: UIImage?

    
    func register() {

        let trimmedName = fullName.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        let trimmedEmail = email.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !trimmedName.isEmpty else {

            showError(
                message: "Please enter your full name."
            )
            return
        }

        guard !trimmedEmail.isEmpty else {

            showError(
                message: "Please enter your email address."
            )
            return
        }

        guard ValidationManager.isValidEmail(
            trimmedEmail
        ) else {

            showError(
                message: "Please enter a valid email address."
            )
            return
        }

        guard !password.isEmpty else {

            showError(
                message: "Please enter a password."
            )
            return
        }

        guard ValidationManager.isValidPassword(
            password
        ) else {

            showError(
                message: """
                Password must contain at least 8 characters, one uppercase letter, one lowercase letter, one number and one special character.
                """
            )
            return
        }

        guard !confirmPassword.isEmpty else {

            showError(
                message: "Please confirm your password."
            )
            return
        }

        guard password == confirmPassword else {

            showError(
                message: "Passwords do not match."
            )
            return
        }

        showSuccess(
            title: "Success",
            message: "Account created successfully."
        )
    }
}
