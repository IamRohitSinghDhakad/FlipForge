//
//  CustomScreen.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 19/06/26.
//

import SwiftUI

struct CustomScreen<Content: View>: View {

    let content: Content

    init(
        @ViewBuilder content: () -> Content
    ) {
        self.content = content()
    }

    var body: some View {

        ScrollView(showsIndicators: false) {

            content
                .frame(maxWidth: .infinity)
                .padding(.vertical)
        }
        .scrollDismissesKeyboard(.interactively)
        .hideKeyboardOnTap()
    }
}
