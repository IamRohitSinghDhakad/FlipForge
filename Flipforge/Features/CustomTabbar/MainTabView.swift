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
    @EnvironmentObject var coordinator: AppCoordinator
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
                    
                case .propertyInquiry(let mode):
                    
                    PropertyInquiryView(
                        mode: mode
                    )
                    
                case .dealAnalysis(let result):
                    
                    PropertyResultView(
                        result: result
                    )
                case .profile:
                    
                    Text("Profile")
                    
                case .settings:
                    
                    Text("Settings")
                    
                case .masterSettings:
                    
                    MasterSettingsView()
                    
                case .subscription:
                    
                    SubscriptionView()
                    
                case .webPage(
                    let title,
                    let url
                ):
                    
                    WebPageView(
                        title: title,
                        urlString: url
                    )
                case .subscriptionCheckout(let url):

                    SubscriptionWebView(
                        urlString: url
                    ) {
                        coordinator.showMainTab()
                    }
                    
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
            
            PropertyInquiryView(
                mode: .create
            )
            
        case .settings:
            
            SettingsView()
            
        }
    }
}
