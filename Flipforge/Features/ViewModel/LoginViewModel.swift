//
//  LoginViewModel.swift
//  Flipforge
//
//  Created by Rohit Singh Dhakad on 03/07/26.
//


import Foundation
import SwiftUI
import Combine


@MainActor
final class LoginViewModel: ObservableObject {
    
    // MARK: - Published Properties
    
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var isLoginSuccessful = false
    
    // Store response if needed
    @Published var loginResponse: LoginModel?
    
    // MARK: - Dependencies
    
    private let repository: AuthRepositoryProtocol

    init(repository: AuthRepositoryProtocol? = nil) {
        self.repository = repository ?? AuthRepository()
    }
    
    // MARK: - Login
    
    func login() async {
        
        guard !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            errorMessage = "Please enter email."
            return
        }
        
        guard !password.isEmpty else {
            errorMessage = "Please enter password."
            return
        }
        
        isLoading = true
        errorMessage = nil
        
        defer {
            isLoading = false
        }
        
        do {
            let response = try await repository.login(
                email: email,
                password: password
            )

            if response.status == 1 {
                loginResponse = response
                if let userId = response.result?.userId {
                    UserSession.userId = userId
                }
                isLoginSuccessful = true
            } else {
                errorMessage = response.message
            }
            
        } catch {
            
            errorMessage = error.localizedDescription
        }
    }
}



