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

                if case .error(let message) = response.result {
                    showAlert(message)
                } else {
                    showAlert(response.message)
                }

                return
            }
            
            guard case .user(let user) = response.result else {
                return
            }

            UserSession.saveSession(
                userId: user.userId,
                userName: user.name,
                email: user.email,
                profileImage: user.userImage
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
            showAlert("Please enter your full name.")
            return false
        }

        guard !trimmedEmail.isEmpty else {
            showAlert("Please enter your email address.")
            return false
        }

        guard ValidationManager.isValidEmail(trimmedEmail) else {
            showAlert("Please enter a valid email address.")
            return false
        }

        guard !password.isEmpty else {
            showAlert("Please enter a password.")
            return false
        }

        guard ValidationManager.isValidPassword(password) else {
            showAlert("""
            Password must contain at least 8 characters, one uppercase letter, one lowercase letter, one number and one special character.
            """)
            return false
        }

        guard !confirmPassword.isEmpty else {
            showAlert("Please confirm your password.")
            return false
        }

        guard password == confirmPassword else {
            showAlert("Passwords do not match.")
            return false
        }

//        guard profileImage != nil else {
//            showError("Please select a profile picture.")
//            return false
//        }

        return true
    }
}
