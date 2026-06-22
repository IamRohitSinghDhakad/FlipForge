//
//  CustomTabItem.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 22/06/26.
//

import SwiftUI
import Foundation

enum AppTab {
    case home
    case addProperty
    case settings
}

struct CustomTabItem: View {

    let icon: String
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {

        Button(action: action) {

            VStack(spacing: 4) {

                Image(systemName: icon)
                    .font(.system(size: 24))

                Text(title)
                    .font(.caption)
            }
            .foregroundColor(
                isSelected
                ? .white
                : .gray
            )
        }
    }
}
