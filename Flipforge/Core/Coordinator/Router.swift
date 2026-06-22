//
//  Router.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 22/06/26.
//

import SwiftUI
import Combine

final class Router: ObservableObject {

    @Published var path = NavigationPath()

    func push(_ route: AppRoute) {
        path.append(route)
    }

    func pop() {

        guard !path.isEmpty else {
            return
        }

        path.removeLast()
    }

    func popToRoot() {
        path = NavigationPath()
    }
}
