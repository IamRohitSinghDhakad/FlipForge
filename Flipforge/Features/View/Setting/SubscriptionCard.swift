//
//  SubscriptionCard.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 23/06/26.
//

import SwiftUI

struct SubscriptionCard: View {

    let plan: SubscriptionPlan

    var body: some View {

        VStack(spacing: 24) {

            if plan.isPopular {

                Text("MOST POPULAR")
                    .font(.caption)
                    .bold()
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(Color.orange)
                    .clipShape(Capsule())
                    .foregroundColor(.white)
            }

            Text(plan.title)
                .font(.title.bold())
                .foregroundColor(.white)

            VStack(spacing: 8) {

                Text(plan.trialPrice)
                    .font(.system(size: 56))
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                Text(plan.trialDuration)
                    .foregroundColor(.gray)

                Divider()

                Text(
                    "\(plan.regularPrice)/\(plan.billingCycle)"
                )
                .font(.system(size: 40))
                .fontWeight(.bold)
                .foregroundColor(.white)

                Text("After trial period")
                    .foregroundColor(.gray)
            }

            Divider()

            VStack(
                alignment: .leading,
                spacing: 18
            ) {

                ForEach(
                    plan.features,
                    id: \.self
                ) { feature in

                    HStack {

                        Image(
                            systemName: "checkmark.circle.fill"
                        )
                        .foregroundColor(.green)

                        Text(feature)
                            .foregroundColor(.white)

                        Spacer()
                    }
                }
            }

            Spacer()
        }
        .padding(24)
        .background(
            RoundedRectangle(
                cornerRadius: 28
            )
            .fill(
                Color(
                    red: 12/255,
                    green: 38/255,
                    blue: 88/255
                )
            )
        )
        .overlay {

            RoundedRectangle(
                cornerRadius: 28
            )
            .stroke(
                Color.white.opacity(0.1),
                lineWidth: 1
            )
        }
    }
}
