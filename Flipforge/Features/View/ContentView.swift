//
//  ContentView.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 19/06/26.
//

import Foundation
import SwiftUI
import Combine

struct ContentView: View {
    
    @EnvironmentObject var coordinator: AppCoordinator
    
    var body: some View {
        ZStack {
            Image(.splashBg)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            Image(.logo)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: 200, maxHeight: 200)
        }
        
        .task {
            try? await Task.sleep(for: .seconds(3))
            coordinator.showLogin()
        }
    }
}

#Preview {
    ContentView()
}
