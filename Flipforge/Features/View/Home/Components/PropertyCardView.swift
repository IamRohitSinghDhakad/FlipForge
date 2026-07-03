//
//  PropertyCardView.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 22/06/26.
//

import SwiftUI


struct PropertyCardView: View {

    let property: PropertyModel
    let onEdit: () -> Void
    let onDelete: () -> Void
    let onTap: () -> Void

    var body: some View {

        HStack(alignment: .top, spacing: 2) {

            Image(.property)
                .resizable()
                .scaledToFit()
                .frame(width: 70, height: 70)

            VStack(alignment: .leading, spacing: 6) {

                Text(property.propertyAddress)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white)
                    .fixedSize(horizontal: false, vertical: true)

                Text("Total Sq. Feet: \(property.totalSqFeet) sqft")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)

                Text("Purchase Price")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)

                Text("$\(property.purchasePrice)")
                    .font(.system(size: 20, weight: .bold))
                    .foregroundColor(.white)

                Spacer(minLength: 0)
            }

            Spacer()

            VStack(spacing: 10) {

                Button {
                    onEdit()
                } label: {

                    Text("Edit")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(.white)
                        .frame(width: 85, height: 36)
                        .background(
                            Capsule()
                                .fill(Color.white.opacity(0.08))
                        )
                        .overlay(
                            Capsule()
                                .stroke(Color.white.opacity(0.35), lineWidth: 1)
                        )
                }

                Button {
                    onDelete()
                } label: {

                    Text("Delete")
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(.white)
                        .frame(width: 85, height: 36)
                        .background(
                            Capsule()
                                .fill(Color.red.opacity(0.15))
                        )
                        .overlay(
                            Capsule()
                                .stroke(Color.red.opacity(0.6), lineWidth: 1)
                        )
                }

                Spacer()
            }.buttonStyle(.plain)
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 20)
                .fill(
                    Color(
                        red: 17/255,
                        green: 49/255,
                        blue: 109/255
                    )
                )
        )
        .onTapGesture {
            onTap()
        }
    }
}
