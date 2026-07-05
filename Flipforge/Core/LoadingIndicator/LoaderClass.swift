//
//  LoaderClass.swift
//  Flipforge
//
//  Created by Rohit Singh Dhakad on 05/07/26.
//

import SwiftUI

struct LoadingView: View {

    @State private var rotate = false
    @State private var pulse = false
    @State private var scale = false

    var body: some View {

        ZStack {

            Color.black
                .opacity(0.8)
                .ignoresSafeArea()

//            Rectangle()
//                .fill(.ultraThinMaterial)
//                .ignoresSafeArea()

            VStack(spacing: 28) {

                ZStack {

                    Circle()
                        .stroke(
                            Color.orange.opacity(0.35),
                            lineWidth: 3
                        )
                        .frame(width: 135, height: 135)
                        .scaleEffect(pulse ? 1.15 : 0.9)
                        .opacity(pulse ? 0 : 1)

                    Circle()
                        .stroke(
                            Color.black.opacity(0.2),
                            lineWidth: 2
                        )
                        .frame(width: 105, height: 105)
                        .rotationEffect(
                            .degrees(rotate ? 360 : 0)
                        )

                    Image(.logo)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 85)
                        .scaleEffect(scale ? 1.05 : 0.95)
                        .shadow(
                            color: .orange.opacity(0.8),
                            radius: 25
                        )
                }

                Text("Loading...")
                    .foregroundColor(.white)
                    .font(.headline)
            }
        }
        .onAppear {

            withAnimation(
                .linear(duration: 2)
                .repeatForever(autoreverses: false)
            ) {
                rotate.toggle()
            }

            withAnimation(
                .easeOut(duration: 1.4)
                .repeatForever(autoreverses: false)
            ) {
                pulse.toggle()
            }

            withAnimation(
                .easeInOut(duration: 1)
                .repeatForever()
            ) {
                scale.toggle()
            }
        }
    }
}
