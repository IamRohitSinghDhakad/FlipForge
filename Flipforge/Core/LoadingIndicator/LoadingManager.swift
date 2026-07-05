//
//  LoadingManager.swift
//  Flipforge
//
//  Created by Rohit Singh Dhakad on 05/07/26.
//

import SwiftUI
import Combine

@MainActor
final class LoadingManager: ObservableObject {

    static let shared = LoadingManager()

    @Published private(set) var isLoading = false

    private var loadingCount = 0

    private init() {}

    func show() {
        loadingCount += 1
        isLoading = true
    }

    func hide() {
        loadingCount = max(loadingCount - 1, 0)
        isLoading = loadingCount > 0
    }

    func reset() {
        loadingCount = 0
        isLoading = false
    }
}


struct GlobalLoadingModifier: ViewModifier {

    @StateObject
    private var loadingManager = LoadingManager.shared

    func body(content: Content) -> some View {

        ZStack {

            content

            if loadingManager.isLoading {

                LoadingView()
                    .transition(.opacity)
                    .zIndex(9999)
            }
        }
        .animation(.easeInOut(duration: 0.25),
                   value: loadingManager.isLoading)
    }
}

extension View {

    func globalLoading() -> some View {

        modifier(GlobalLoadingModifier())
    }
}
