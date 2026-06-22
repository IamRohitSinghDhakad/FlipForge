//
//  TabBarViewModel.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 22/06/26.
//

import Foundation
import SwiftUI
import Combine

@MainActor
final class TabBarViewModel: ObservableObject {

    @Published var selectedTab: AppTab = .home
}
