//
//  ForgotPasswordViewModel.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 22/06/26.
//

import Foundation
import Combine

@MainActor
final class ForgotPasswordViewModel: BaseViewModel {

    @Published var email = ""

    func submit() {

        let email = email.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !email.isEmpty else {

            showError(
                message: "Please enter your email address."
            )
            return
        }

        guard ValidationManager.isValidEmail(email) else {

            showError(
                message: "Please enter a valid email address."
            )
            return
        }

        showSuccess(
            title: "Success",
            message: "Password reset instructions have been sent to your email."
        )
    }
}
