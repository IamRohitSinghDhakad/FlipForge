//
//  FixHeaderScreen.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 23/06/26.
//
import Foundation
import SwiftUI


struct FixedHeaderScreen<
    Header: View,
    Content: View
>: View {

    let header: Header
    let content: Content

    init(
        @ViewBuilder header: () -> Header,
        @ViewBuilder content: () -> Content
    ) {
        self.header = header()
        self.content = content()
    }

    var body: some View {

        VStack(spacing: 0) {

            header

            ScrollView(showsIndicators: false) {

                content
            }
        }
        .hideKeyboardOnTap()
    }
}
