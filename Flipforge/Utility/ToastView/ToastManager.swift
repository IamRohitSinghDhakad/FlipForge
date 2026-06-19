//
//  ToastManager.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 19/06/26.
//

import Foundation
import Combine

final class AppState {

    static let shared = AppState()
    let toastManager = ToastManager()
    private init() { }
}

final class ToastManager: ObservableObject {

    @Published var toast: ToastModel?

    func show(
        type: ToastType,
        title: String,
        message: String
    ) {

        toast = ToastModel(
            type: type,
            title: title,
            message: message
        )

        DispatchQueue.main.asyncAfter(
            deadline: .now() + 3
        ) {

            self.toast = nil
        }
    }
}
