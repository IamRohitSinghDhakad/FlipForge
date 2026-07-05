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

        guard !UserSession.userId.isEmpty else {
            showError("User not found.")
            return
        }

        let userId = UserSession.userId

        LoadingManager.shared.show()
        defer { LoadingManager.shared.hide() }

        do {

            let response = try await repository.getProfile(
                userId: userId
            )

            guard response.status == 1 else {
                showError(response.message)
                return
            }

            profile = response.result

        } catch {

            showApiError(error)
        }
    }
}
