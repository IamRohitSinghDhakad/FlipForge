//
//  SubscriptionCard.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 23/06/26.
//

import SwiftUI

struct SubscriptionCard: View {

    var body: some View {

        VStack(spacing: 24) {

            Text("$4.99")
                .font(.system(size: 56, weight: .bold))
                .foregroundColor(.white)

            Text("For first 2 weeks")
                .foregroundColor(.gray)

            Divider()

            Text("$19.99/month")
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(.white)

            Text("After first 2 weeks")
                .foregroundColor(.gray)

            Divider()

            VStack(alignment: .leading, spacing: 18) {

                feature("Unlimited Property Inquiries")
                feature("Full Deal Analysis & Reports")
                feature("Export Results as PDF")
                feature("Priority Support")
            }
        }
        .padding(24)
        .background(
            RoundedRectangle(cornerRadius: 28)
                .fill(
                    Color(
                        red: 12/255,
                        green: 38/255,
                        blue: 88/255
                    )
                )
        )
        .overlay(
            RoundedRectangle(cornerRadius: 28)
                .stroke(Color.white.opacity(0.1), lineWidth: 1)
        )
    }

    @ViewBuilder
    private func feature(_ title: String) -> some View {

        HStack {

            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(.green)

            Text(title)
                .foregroundColor(.white)

            Spacer()
        }
    }
}
