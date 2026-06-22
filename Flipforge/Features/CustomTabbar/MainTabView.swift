//
//  MainTabView.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 22/06/26.
//

import SwiftUI
import Combine
import Foundation

import SwiftUI

struct MainTabView: View {

    @EnvironmentObject var router: Router

    @State private var selectedTab: AppTab = .home

    var body: some View {

        NavigationStack(path: $router.path) {

            ZStack(alignment: .bottom) {

                tabContent

                CustomTabBar(
                    selectedTab: $selectedTab
                )
                .padding(.horizontal, 12)
                .padding(.bottom, 10)
            }
            .ignoresSafeArea(.keyboard)

            .navigationDestination(
                for: AppRoute.self
            ) { route in

                switch route {

                case .propertyInquiry(let property):

                    PropertyInquiryView(
                        property: property
                    )

                case .propertyResult:

                    Text("Property Result")

                case .profile:

                    Text("Profile")

                case .settings:

                    Text("Settings")
                }
            }
        }
    }
}

extension MainTabView {

    @ViewBuilder
    private var tabContent: some View {

        switch selectedTab {

        case .home:

            HomeView()

        case .addProperty:

            EmptyView()

        case .settings:

            EmptyView()

        }
    }
}
