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
    @State private var progress: Double = 0
    
    @EnvironmentObject var router: Router
    
    var body: some View {
        
        ZStack {
            
            Image(.loginBg)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(spacing: 8) {

                CustomNavigationBar(
                    title: title,
                    subtitle: nil
                ) {
                    router.pop()
                }
                .padding(.horizontal, 20)

                if progress > 0 {

                    ProgressView(value: progress)
                        .tint(.orange)
                        .padding(.horizontal, 28)
                }

                CustomWebView(
                    urlString: urlString,
                    progress: $progress
                )
                .background(
                    RoundedRectangle(cornerRadius: 24)
                        .fill(Color(uiColor: .systemBackground))
                )
                .clipShape(
                    RoundedRectangle(cornerRadius: 24)
                )
                .overlay {
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(Color.white.opacity(0.15), lineWidth: 1)
                }
                .shadow(color: .black.opacity(0.25), radius: 15, y: 8)
                .padding(.horizontal, 20)
                .padding(.bottom, 16)
            }
        }
        .globalLoading()
        .navigationBarBackButtonHidden(true)
    }
}
