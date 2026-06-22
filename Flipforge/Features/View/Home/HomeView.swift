//
//  HomeView.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 22/06/26.
//

import SwiftUI

struct HomeView: View {

    @StateObject private var vm = HomeViewModel()

    var body: some View {

        ZStack {

            Image(.loginBg)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack(spacing: 0) {

                HomeHeaderView(
                    userName: vm.userName
                )
                .padding(.horizontal, 20)
                .padding(.top, 50)
                .padding(.bottom, 15)

                ScrollView(
                    showsIndicators: false
                ) {

                    LazyVStack(
                        spacing: 16
                    ) {

                        ForEach(vm.properties) { property in

                            PropertyCardView(
                                property: property
                            ) {

                                print("Edit tapped")
                            }
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.bottom, 120)
                }
            }
        }
    }
}



#Preview {
    HomeView()
}
