//
//  SettingViewModel.swift
//  Flipforge
//
//  Created by Rohit Singh Dhakad on 03/07/26.
//


import Foundation
import Combine

@MainActor
final class SettingsViewModel: BaseViewModel {

    @Published var profile: ProfileUser?

    private let repository: AuthRepositoryProtocol

    init(repository: AuthRepositoryProtocol? = nil) {
        self.repository = repository ?? AuthRepository()
    }

    func loadProfile() async {

        guard let userId = UserSession.userId else {
            showError(message: "User not found.")
            return
        }

        isLoading = true
        defer {
            isLoading = false
        }

        do {

            let response = try await repository.getProfile(
                userId: userId
            )

            guard response.status == 1 else {
                showError(message: response.message)
                return
            }

            profile = response.result

        } catch {

            showApiError(error)
        }
    }
}
