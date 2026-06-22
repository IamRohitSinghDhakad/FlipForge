//
//  KeyboardAdaptive.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 22/06/26.
//

import SwiftUI


import SwiftUI

struct KeyboardManagerModifier: ViewModifier {

    func body(content: Content) -> some View {

        content
            .modifier(KeyboardAdaptive())
            .hideKeyboardOnTap()
            .toolbar {

                ToolbarItemGroup(
                    placement: .keyboard
                ) {

                    Spacer()

                    Button("Done") {

                        UIApplication.shared.endEditing()
                    }
                }
            }
    }
}


struct KeyboardAdaptive: ViewModifier {

    @State private var keyboardHeight: CGFloat = 0

    func body(content: Content) -> some View {

        content
            .padding(.bottom, keyboardHeight)
            .animation(
                .easeOut(duration: 0.25),
                value: keyboardHeight
            )
            .onReceive(
                NotificationCenter.default.publisher(
                    for: UIResponder.keyboardWillShowNotification
                )
            ) { notification in

                guard let frame =
                        notification.userInfo?[
                            UIResponder.keyboardFrameEndUserInfoKey
                        ] as? CGRect
                else { return }

                keyboardHeight = frame.height - 120
            }
            .onReceive(
                NotificationCenter.default.publisher(
                    for: UIResponder.keyboardWillHideNotification
                )
            ) { _ in

                keyboardHeight = 0
            }
    }
}


extension View {

    func keyboardManager() -> some View {

        modifier(
            KeyboardManagerModifier()
        )
    }
}
