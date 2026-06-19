//
//  CustomNavigationBar.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 19/06/26.
//

import SwiftUI

struct CustomNavigationBar: View {

    let title: String
    let subtitle: String?

    var onBack: (() -> Void)?

    var body: some View {

        VStack(spacing: 0) {

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
            .padding(.leading, 4)
            .padding(.trailing, 16)

            .padding(.horizontal, 12)

            VStack(spacing: 6) {

                Text(title)
                    .font(.system(size: 34, weight: .bold))
                    .foregroundColor(.white)

                if let subtitle {

                    Text(subtitle)
                        .font(.system(size: 18))
                        .foregroundColor(.gray)
                }
            }
            .padding(.top, 4)
        }
    }
}
