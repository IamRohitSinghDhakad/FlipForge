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
    
    private let repository: AuthRepositoryProtocol

    init(repository: AuthRepositoryProtocol = AuthRepository()) {
        self.repository = repository
        super.init()
    }
    
    
    func register(
        coordinator: AppCoordinator
    ) async {

        guard validate() else { return }

        LoadingManager.shared.show()
        defer { LoadingManager.shared.hide() }

        do {

            let response = try await repository.signup(
                name: fullName.trimmingCharacters(in: .whitespacesAndNewlines),
                email: email.trimmingCharacters(in: .whitespacesAndNewlines),
                password: password,
                image: profileImage
            )

            guard response.status == 1 else {
                showError(response.message)
                return
            }
            
            UserSession.saveSession(
                userId: response.result.userId,
                userName: response.result.name,
                email: response.result.email,
                profileImage: response.result.userImage
            )


            coordinator.showMainTab()

        } catch {
            showApiError(error)
        }
    }

    
    private func validate() -> Bool {

        let trimmedName = fullName.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmedName.isEmpty else {
            showError("Please enter your full name.")
            return false
        }

        guard !trimmedEmail.isEmpty else {
            showError("Please enter your email address.")
            return false
        }

        guard ValidationManager.isValidEmail(trimmedEmail) else {
            showError("Please enter a valid email address.")
            return false
        }

        guard !password.isEmpty else {
            showError("Please enter a password.")
            return false
        }

        guard ValidationManager.isValidPassword(password) else {
            showError("""
            Password must contain at least 8 characters, one uppercase letter, one lowercase letter, one number and one special character.
            """)
            return false
        }

        guard !confirmPassword.isEmpty else {
            showError("Please confirm your password.")
            return false
        }

        guard password == confirmPassword else {
            showError("Passwords do not match.")
            return false
        }

//        guard profileImage != nil else {
//            showError("Please select a profile picture.")
//            return false
//        }

        return true
    }
}
