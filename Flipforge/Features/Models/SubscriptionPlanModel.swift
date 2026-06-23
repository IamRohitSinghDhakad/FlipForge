//
//  SubscriptionPlanModel.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 23/06/26.
//

import Foundation

struct SubscriptionPlan: Identifiable {

    let id = UUID()

    let title: String
    let trialPrice: String
    let trialDuration: String

    let regularPrice: String
    let billingCycle: String

    let features: [String]

    let isPopular: Bool
}
