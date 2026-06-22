//
//  FlipforgeApp.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 19/06/26.
//

import SwiftUI

@main
struct FlipforgeApp: App {
    
    @StateObject private var coordinator = AppCoordinator()

       @StateObject private var router =
       Router()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                          .environmentObject(
                              coordinator
                          )
                          .environmentObject(
                              router
                          )
                .customToast(
                    manager: DependencyContainer.shared.toastManager
                )
        }
    }
}
