//
//  EmptyStateView.swift
//  Flipforge
//
//  Created by Rohit Singh Dhakad on 06/07/26.
//

import SwiftUI

struct EmptyStateView: View {

    let icon: String
    let title: String
    let message: String

    var buttonTitle: String?
    var buttonAction: (() -> Void)?

    var body: some View {

        VStack(spacing: 18) {

            Image(systemName: icon)
                .font(.system(size: 70))
                .foregroundStyle(.orange)

            Text(title)
                .font(.title2.bold())
                .foregroundColor(.white)

            Text(message)
                .font(.body)
                .foregroundColor(.white.opacity(0.8))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)

            if let buttonTitle {

                Button(buttonTitle) {
                    buttonAction?()
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 12)
                .background(.orange)
                .foregroundColor(.white)
                .clipShape(Capsule())
                .padding(.top, 8)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 24)
    }
}


extension View {

    @ViewBuilder
    func emptyState(
        when isEmpty: Bool,
        icon: String,
        title: String,
        message: String,
        buttonTitle: String? = nil,
        buttonAction: (() -> Void)? = nil
    ) -> some View {

        if isEmpty {

            EmptyStateView(
                icon: icon,
                title: title,
                message: message,
                buttonTitle: buttonTitle,
                buttonAction: buttonAction
            )

        } else {

            self
        }
    }
}
