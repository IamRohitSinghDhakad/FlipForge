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
    @Published var resetCompleted = false
    private let repository: AuthRepositoryProtocol

    init(
        repository: AuthRepositoryProtocol = AuthRepository()
    ) {
        self.repository = repository
        super.init()
    }

    func submit() async {

        let email = email.trimmingCharacters(
            in: .whitespacesAndNewlines
        )

        guard !email.isEmpty else {
            showAlert("Please enter your email address.")
            return
        }

        guard ValidationManager.isValidEmail(email) else {
            showAlert("Please enter a valid email address.")
            return
        }

        LoadingManager.shared.show()
        defer { LoadingManager.shared.hide() }
        
        do {

            let response = try await repository.forgotPassword(
                email: email
            )

            if response.status == "1" {

                self.email = ""

                showSuccessAlert("""
                    If an account exists for this email address, a password reset link has been sent to your registered email.

                    Please check your inbox and spam folder.
                    """)

                resetCompleted = true

            } else {

                showAlert(response.result)
            }
        } catch {

            showApiError(error)
        }
    }
}
