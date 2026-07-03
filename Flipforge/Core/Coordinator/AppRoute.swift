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
    case propertyInquiry(InquiryMode)
    case dealAnalysis(PropertyAnalysisResult)
    case masterSettings
    case subscription
    case webPage(
           title: String,
           url: String
       )
    case profile
    case settings
}
