//
//  CustomTabBar.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 22/06/26.
//

import SwiftUI

struct CustomTabBar: View {

    @Binding var selectedTab: AppTab

    var body: some View {

        HStack {

            Spacer()

            CustomTabItem(
                icon: "house.fill",
                title: "Home",
                isSelected: selectedTab == .home
            ) {

                selectedTab = .home
            }

            Spacer()

            centerButton

            Spacer()

            CustomTabItem(
                icon: "gearshape.fill",
                title: "Settings",
                isSelected: selectedTab == .settings
            ) {

                selectedTab = .settings
            }

            Spacer()
        }
        .padding(.vertical, 15)
        .background(
            RoundedRectangle(
                cornerRadius: 30
            )
            .fill(
                Color(
                    red: 0/255,
                    green: 26/255,
                    blue: 77/255
                )
            )
            .shadow(
                color: .black.opacity(0.25),
                radius: 10,
                y: -5
            )
        )
    }
    
    private var centerButton: some View {

        Button {

            selectedTab = .addProperty

        } label: {

            ZStack {

                Circle()
                    .fill(Color.orange)
                    .frame(width: 70, height: 70)

                Image(systemName: "plus")
                    .font(.system(size: 32))
                    .foregroundColor(.white)
            }
            .offset(y: -25)
        }
    }
}




//
//#Preview {
//    CustomTabBar()
//}
