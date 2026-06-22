//
//  NavigationHandler.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 19/06/26.
//

import Foundation
import SwiftUI
import Combine

enum Route: Hashable {
    case login
    case home
    case settings
    case detail(id: Int)
    // add other app routes here
}

//@MainActor
//final class Router: ObservableObject {
//    @Published var path = NavigationPath()
//    // Push a new route
//    func navigate(to route: Route) {
//        path.append(route)
//    }
//    // Go back one step
//    func navigateBack() {
//        if path.count > 0 {
//            path.removeLast()
//        }
//    }
//    // Return to root
//    func navigateToRoot() {
//        path.removeLast(path.count)
//    }
//}
