//
//  CustomTextField.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 19/06/26.
//

import SwiftUI

struct CustomTextField: View {

    let placeholder: String
        let icon: String

        @Binding var text: String

        var iconColor: Color = .white
        var textColor: Color = .white
        var placeholderColor: Color = .gray

        var body: some View {

            HStack(spacing: 15) {

                Image(systemName: icon)
                    .foregroundColor(iconColor)
                    .font(.title3)

                TextField(
                    "",
                    text: $text,
                    prompt: Text(placeholder)
                        .foregroundColor(placeholderColor)
                )
                .foregroundColor(textColor)
            }
            .padding()
            .frame(height: 65)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(AppColors.border)
            )
        }
    }



struct CustomSecureField: View {

    let placeholder: String

     @Binding var text: String

     var iconColor: Color = .white
     var textColor: Color = .white
     var placeholderColor: Color = .gray

     @State private var isSecure = true

     var body: some View {

         HStack {

             Image(systemName: "lock.fill")
                 .foregroundColor(iconColor)

             Group {

                 if isSecure {

                     SecureField(
                         "",
                         text: $text,
                         prompt: Text(placeholder)
                             .foregroundColor(placeholderColor)
                     )
                     .foregroundColor(textColor)

                 } else {

                     TextField(
                         "",
                         text: $text,
                         prompt: Text(placeholder)
                             .foregroundColor(placeholderColor)
                     )
                     .foregroundColor(textColor)
                 }
             }

             Button {
                 isSecure.toggle()
             } label: {
                 Image(systemName: isSecure ? "eye.fill" : "eye.slash.fill")
                     .foregroundColor(iconColor)
             }
         }
         .padding()
         .frame(height: 65)
         .overlay(
             RoundedRectangle(cornerRadius: 20)
                 .stroke(AppColors.border)
         )
     }
 }
