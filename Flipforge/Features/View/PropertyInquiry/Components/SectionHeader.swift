//
//  SectionHeader.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 22/06/26.
//

import SwiftUI

struct SectionHeader: View {

    let title: String
    let color: Color

    var body: some View {

        Text(title)
            .font(
                .system(
                    size: 18,
                    weight: .bold
                )
            )
            .foregroundColor(color)
            .frame(
                maxWidth: .infinity,
                alignment: .leading
            )
    }
}
