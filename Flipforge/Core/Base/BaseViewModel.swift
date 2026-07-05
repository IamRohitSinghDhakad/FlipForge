//
//  BaseViewModel.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 19/06/26.
//

import Foundation
import Combine

@MainActor
class BaseViewModel: ObservableObject {

    let toastManager = DependencyContainer.shared.toastManager

    func showSuccess(
        title: String,
        message: String
    ) {
        toastManager.show(
            type: .success,
            title: title,
            message: message
        )
    }

    func showError(
        _ message: String,
        title: String = "Error"
    ) {
        toastManager.show(
            type: .error,
            title: title,
            message: message
        )
    }

    func showWarning(
        title: String = "Warning",
        message: String
    ) {
        toastManager.show(
            type: .warning,
            title: title,
            message: message
        )
    }

    func showApiError(_ error: Error) {
        showError(error.localizedDescription)
    }
}
