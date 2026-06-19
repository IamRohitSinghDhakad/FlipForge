//
//  CustomToastView.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 19/06/26.
//

import SwiftUI


struct CustomToastView: View {

    let toast: ToastModel

    var body: some View {

        HStack(spacing: 15) {

            Image(systemName: toast.type.icon)
                .font(.title2)

            VStack(
                alignment: .leading,
                spacing: 4
            ) {

                Text(toast.title)
                    .fontWeight(.bold)

                Text(toast.message)
                    .font(.caption)
            }

            Spacer()
        }
        .foregroundColor(.white)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(toast.type.color)
        )
        .shadow(radius: 8)
        .padding(.horizontal)
    }
}
