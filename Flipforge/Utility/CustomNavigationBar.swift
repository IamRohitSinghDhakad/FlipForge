//
//  CustomNavigationBar.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 19/06/26.
//

import SwiftUI

import SwiftUI

struct CustomNavigationBar: View {

    let title: String
    let subtitle: String?

    var onBack: (() -> Void)?

    var body: some View {

        VStack(spacing: 10) {

            ZStack {

                Text(title)
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(.white)

                HStack {

                    Button {

                        onBack?()

                    } label: {

                        Image(systemName: "chevron.left")
                            .font(.system(size: 22, weight: .medium))
                            .foregroundColor(.white)
                            .frame(width: 44, height: 44)
                    }

                    Spacer()
                }
            }
            .frame(height: 44)

            if let subtitle {

                Text(subtitle)
                    .font(.system(size: 16))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 60) // Increase top spacing here
        .padding(.bottom, 20)
    }
}
