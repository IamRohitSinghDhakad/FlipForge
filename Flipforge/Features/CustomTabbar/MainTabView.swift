//
//  MainTabView.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 22/06/26.
//

import SwiftUI

struct MainTabView: View {

    @StateObject private var vm =
    TabBarViewModel()

    var body: some View {

        ZStack(alignment: .bottom) {

            currentScreen

            CustomTabBar(
                selectedTab: $vm.selectedTab
            )
            .padding(.horizontal, 5)
            .padding(.bottom, 10)
        }
        .ignoresSafeArea(.keyboard)
    }
    
    @ViewBuilder
    private var currentScreen: some View {

        switch vm.selectedTab {

        case .home:
            HomeView()
        case .addProperty:
            HomeView()
        case .settings:
            HomeView()
        }
    }

}


