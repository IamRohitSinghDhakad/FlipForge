//
//  DependencyContainer.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 20/06/26.
//

import Foundation
import SwiftUI
import Combine


final class DependencyContainer {

    static let shared = DependencyContainer()

    let toastManager = ToastManager()

    private init() { }
}
