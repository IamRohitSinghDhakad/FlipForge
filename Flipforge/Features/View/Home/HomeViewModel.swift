//
//  HomeViewModel.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 22/06/26.
//

import Foundation
import SwiftUI
import Combine

@MainActor
final class HomeViewModel: BaseViewModel {

    @Published var userName = ""
    @Published var properties: [PropertyModel] = []

    @Published var errorMessage: String?

    @Published var showMembershipAlert = false
    @Published var propertyToDelete: PropertyModel?

    private let repository: AuthRepositoryProtocol

    init(repository: AuthRepositoryProtocol? = nil) {
        self.repository = repository ?? AuthRepository()
    }
    
    func loadData() async {

        guard !UserSession.userId.isEmpty else {
            showError("User not found.")
            return
        }

        let userId = UserSession.userId

        LoadingManager.shared.show()
        defer { LoadingManager.shared.hide() }

        do {
            let profile = try await repository.getProfile(
                userId: userId
            )

            guard profile.status == 1 else {
                errorMessage = profile.message
                return
            }
            userName = profile.result.name

            guard profile.result.status == "1" else {
                showMembershipAlert = true
                return
            }
            let propertyResponse = try await repository.getProperties(
                userId: userId
            )
            guard propertyResponse.status == 1 else {
                errorMessage = propertyResponse.message
                return
            }
            properties = propertyResponse.result
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    
    
    func deleteProperty(_ property: PropertyModel) async {

        guard !UserSession.userId.isEmpty else {
            showError("User not found.")
            return
        }

        let userId = UserSession.userId

        LoadingManager.shared.show()
        defer { LoadingManager.shared.hide() }
        
        
        do {

            let response = try await repository.deleteProperty(
                request: DeletePropertyRequest(
                    propertyId: property.propertyId,
                    userId: userId
                )
            )

            guard response.status == 1 else {
                showError(response.message)
                return
            }

            showSuccess(title: "Success", message: response.message)

            let propertyResponse = try await repository.getProperties(
                userId: userId
            )

            if propertyResponse.status == 1 {
                properties = propertyResponse.result
            }

        } catch {

            showApiError(error)
        }
    }
    
}
