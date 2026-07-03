//
//  ProfileCard.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 23/06/26.
//
import SwiftUI
import Foundation

struct ProfileCardView: View {
    
    let profile: ProfileUser?
    
    var body: some View {
        
        HStack(spacing: 16) {
            
            RemoteImage(
                url: profile?.userImage,
                placeholder: "profile",
                width: 80,
                height: 80,
                isCircle: true
            )
            
            VStack(
                alignment: .leading,
                spacing: 4
            ) {
                
                Text(profile?.name ?? "")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                
                Text(profile?.email ?? "")
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
