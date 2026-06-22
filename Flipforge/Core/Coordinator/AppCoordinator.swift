//
//  AppCoordinator.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 19/06/26.
//

import Foundation
import Combine

enum AppFlow {
    case splash
    case login
    case register
    case home
    case forgotPassword
    case onboarding
    case mainTab
}

final class AppCoordinator: ObservableObject {
    
    @Published var flow: AppFlow = .splash
    
    func showSplash() {
        flow = .splash
    }
    
    func showLogin() {
        flow = .login
    }
    
    func showHome() {
        flow = .home
    }
    
    func showOnboarding() {
        flow = .onboarding
    }
    
    func showRegister() {
        flow = .register
    }
    
    func showForgotPassword() {
        flow = .forgotPassword
    }
    
    func showMainTab() {
        flow = .mainTab
    }
}
