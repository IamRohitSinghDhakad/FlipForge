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
            showError("Please enter your email address.")
            return
        }

        guard ValidationManager.isValidEmail(email) else {
            showError("Please enter a valid email address.")
            return
        }

        LoadingManager.shared.show()
        defer { LoadingManager.shared.hide() }
        
        do {

            let response = try await repository.forgotPassword(
                email: email
            )

            if response.status == 1 {

                showSuccess(
                    title: "Success",
                    message: response.message
                )

                resetCompleted = true

            } else {

                showError(response.message)
            }

        } catch {

            showApiError(error)
        }
    }
}
