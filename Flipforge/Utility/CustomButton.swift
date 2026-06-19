//
//  CustomButton.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 19/06/26.
//

import SwiftUI

struct CustomButton: View {

    let title: String

    var height: CGFloat = 60

    var backgroundColor: Color = AppColors.orange

    var textColor: Color = .white

    var cornerRadius: CGFloat = 20

    var action: (() -> Void)

    var body: some View {

        Button(action: action) {

            Text(title)
                .font(AppFonts.medium(22))
                .foregroundColor(textColor)
                .frame(maxWidth: .infinity)
                .frame(height: height)
                .background(backgroundColor)
                .cornerRadius(cornerRadius)
        }
    }
}
