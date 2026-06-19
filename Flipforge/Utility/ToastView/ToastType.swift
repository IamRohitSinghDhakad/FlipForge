//
//  ToastType.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 19/06/26.
//

import SwiftUI
import Foundation


enum ToastType {

    case success
    case error
    case warning
    case info

    var color: Color {

        switch self {

        case .success:
            return .green

        case .error:
            return .red

        case .warning:
            return .orange

        case .info:
            return .blue
        }
    }

    var icon: String {

        switch self {

        case .success:
            return "checkmark.circle.fill"

        case .error:
            return "xmark.circle.fill"

        case .warning:
            return "exclamationmark.triangle.fill"

        case .info:
            return "info.circle.fill"
        }
    }
}


struct ToastModel {

    let type: ToastType
    let title: String
    let message: String
}
