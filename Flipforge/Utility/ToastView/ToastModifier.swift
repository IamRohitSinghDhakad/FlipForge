//
//  ToastModifier.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 19/06/26.
//

import SwiftUI

struct ToastModifier: ViewModifier {

    @ObservedObject var manager: ToastManager

    func body(content: Content) -> some View {

        ZStack(alignment: .top) {

            content

            if let toast = manager.toast {

                CustomToastView(toast: toast)
                    .padding(.top, 60)
                    .transition(
                        .move(edge: .top)
                        .combined(with: .opacity)
                    )
            }
        }
        .animation(
            .spring(),
            value: manager.toast != nil
        )
    }
}


extension View {

    func customToast(
        manager: ToastManager
    ) -> some View {

        modifier(
            ToastModifier(
                manager: manager
            )
        )
    }
}
