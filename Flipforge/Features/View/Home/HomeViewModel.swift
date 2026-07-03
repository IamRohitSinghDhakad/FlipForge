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

        guard let userId = UserSession.userId else {
            return
        }

        isLoading = true
        defer {
            isLoading = false
        }

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
    
    
    
}
