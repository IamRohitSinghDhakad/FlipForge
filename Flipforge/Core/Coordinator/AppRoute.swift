//
//  AppRoute.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 22/06/26.
//

import Foundation
import Combine
import SwiftUI


enum AppRoute: Hashable {
    case propertyInquiry(PropertyModel)
    case propertyResult
    case profile
    case settings
}
