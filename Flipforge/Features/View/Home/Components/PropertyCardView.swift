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
    let onTap: () -> Void
    var body: some View {
        
        HStack(alignment: .center, spacing: 10) {
            
            Image(property.imageName)
                .resizable()
                .scaledToFit()
                .frame(
                    width: 65,
                    height: 65
                )
            
            VStack(
                alignment: .leading,
                spacing: 4
            ) {
                
                Text(property.title)
                    .font(
                        .system(
                            size: 14,
                            weight: .semibold
                        )
                    )
                    .foregroundColor(.white)
                    .lineLimit(1)
                
                Text(
                    "Total Sq. Feet: \(Int(property.sqft)) sqft"
                )
                .font(.system(size: 12))
                .foregroundColor(.gray)
                .lineLimit(1)
            }
            
            Spacer(minLength: 8)
            
            VStack(
                alignment: .trailing,
                spacing: 6
            ) {
                
                Text("Purchase Price")
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
                
                Text(
                    "$\(property.purchasePrice, specifier: "%.0f")"
                )
                .font(
                    .system(
                        size: 14,
                        weight: .bold
                    )
                )
                .foregroundColor(.white)
                
                Button {
                    
                    onEdit()
                    
                } label: {
                    
                    Text("Edit")
                        .font(
                            .system(
                                size: 14,
                                weight: .medium
                            )
                        )
                        .foregroundColor(.white)
                        .frame(
                            width: 80,
                            height: 34
                        )
                        .overlay(
                            Capsule()
                                .stroke(
                                    Color.white.opacity(0.3),
                                    lineWidth: 1
                                )
                        )
                }
            }
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 12)
        .background(
            RoundedRectangle(
                cornerRadius: 18
            )
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
