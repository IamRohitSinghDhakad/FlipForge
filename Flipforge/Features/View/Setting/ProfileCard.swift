//
//  ProfileCard.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 23/06/26.
//
import SwiftUI
import Foundation

struct ProfileCardView: View {

    var body: some View {

        HStack(spacing: 16) {

            Image("profile")
                .resizable()
                .scaledToFill()
                .frame(width: 80, height: 80)
                .clipShape(Circle())

            VStack(
                alignment: .leading,
                spacing: 4
            ) {

                Text("Arun Goswami")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)

                Text("goswamipuriarun@gmail.com")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }

            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(
                cornerRadius: 26
            )
            .fill(
                Color(
                    red: 17/255,
                    green: 49/255,
                    blue: 109/255
                )
            )
        )
    }
}
