//
//  WebPageView.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 23/06/26.
//

import SwiftUI

struct WebPageView: View {

    let title: String
    let urlString: String

    @EnvironmentObject var router: Router

    var body: some View {

        ZStack {

            Image(.loginBg)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack(
                spacing: 16
            ) {

                CustomNavigationBar(
                    title: title,
                    subtitle: nil
                ) {
                    router.pop()
                }

                CustomWebView(
                    urlString: urlString
                )
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: 20
                    )
                )
                .padding(.horizontal)
                .padding(.bottom, 12)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}
