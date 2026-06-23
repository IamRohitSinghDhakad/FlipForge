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


extension View {

    func cardStyle() -> some View {

        self
            .background(
                Color(
                    red: 14/255,
                    green: 38/255,
                    blue: 88/255
                )
            )
            .clipShape(
                RoundedRectangle(
                    cornerRadius: 22
                )
            )
            .overlay {

                RoundedRectangle(
                    cornerRadius: 22
                )
                .stroke(
                    Color.white.opacity(0.1)
                )
            }
    }
}
