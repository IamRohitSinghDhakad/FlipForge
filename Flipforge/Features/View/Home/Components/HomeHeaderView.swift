//
//  HomeHeaderView.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 22/06/26.
//

import SwiftUI

struct HomeHeaderView: View {

    let userName: String

    var body: some View {

        VStack(
            alignment: .leading,
            spacing: 4
        ) {

            Text("Welcome, \(userName)!")
                .font(
                    .system(
                        size: 26,
                        weight: .bold
                    )
                )
                .foregroundColor(.white)

            Text("Here's your property overview")
                .font(.title3)
                .foregroundColor(.gray)
        }
        .frame(
            maxWidth: .infinity,
            alignment: .leading
        )
    }
}
