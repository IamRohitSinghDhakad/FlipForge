//
//  Extensions.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 19/06/26.
//

import SwiftUI
import UIKit

enum Field {
    case email
    case password
}


extension View {

    func hideKeyboardOnTap() -> some View {
        modifier(HideKeyboardModifier())
    }
}

private struct HideKeyboardModifier: ViewModifier {

    func body(content: Content) -> some View {
        content
            .contentShape(Rectangle())
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
    }
}




extension UIApplication {

    func endEditing() {
        sendAction(
            #selector(UIResponder.resignFirstResponder),
            to: nil,
            from: nil,
            for: nil
        )
    }
}
