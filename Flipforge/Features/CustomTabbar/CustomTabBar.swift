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
        .padding(.top, 14)
        .padding(.bottom, 14)
        .background {

            RoundedRectangle(cornerRadius: 32)
                .fill(
                    Color(
                        red: 0/255,
                        green: 26/255,
                        blue: 77/255
                    )
                )
                .shadow(
                    color: .black.opacity(0.25),
                    radius: 12,
                    y: -3
                )
        }
    }

    private var centerButton: some View {

        Button {

            selectedTab = .addProperty

        } label: {

            Circle()
                .fill(.orange)
                .frame(width: 72, height: 72)
                .overlay {

                    Image(systemName: "plus")
                        .font(.system(size: 34))
                        .foregroundColor(.white)
                }
                .offset(y: -22)
        }
    }
}




//
//#Preview {
//    CustomTabBar()
//}
