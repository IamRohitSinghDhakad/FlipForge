//
//  InquiryTextField.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 22/06/26.
//

import SwiftUI

struct InquiryField: View {

    let title: String
    let placeholder: String

    @Binding var text: String

    var keyboardType: UIKeyboardType = .default

    var body: some View {

        VStack(
            alignment: .leading,
            spacing: 8
        ) {

            Text(title)
                .font(.system(size: 14))
                .foregroundColor(.white)

            TextField(
                "",
                text: $text,
                prompt: Text(placeholder)
                    .foregroundColor(.gray)
            )
            .keyboardType(keyboardType)
            .foregroundColor(.white)
            .padding()
            .frame(height: 58)
            .background(
                RoundedRectangle(
                    cornerRadius: 18
                )
                .fill(
                    Color(
                        red: 17/255,
                        green: 49/255,
                        blue: 109/255
                    )
                )
            )
        }
    }
}
