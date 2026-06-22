//
//  RootView.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 19/06/26.

import SwiftUI

struct RootView: View {

    @EnvironmentObject var coordinator: AppCoordinator

    var body: some View {

        switch coordinator.flow {

        case .splash:
            ContentView()

        case .login:
            LoginView()

        case .register:
            RegisterView()

        case .forgotPassword:
            ForgotPasswordView()

        case .onboarding:
            ContentView()

        case .mainTab:
            MainTabView()
        }
    }
}
