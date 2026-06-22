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

    func showRegister() {
        flow = .register
    }

    func showForgotPassword() {
        flow = .forgotPassword
    }

    func showOnboarding() {
        flow = .onboarding
    }

    func showMainTab() {
        flow = .mainTab
    }
}
