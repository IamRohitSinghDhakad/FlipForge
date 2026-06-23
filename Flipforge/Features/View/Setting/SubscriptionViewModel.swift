//
//  SubscriptionViewModel.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 23/06/26.
//

import Foundation
import Combine

final class SubscriptionViewModel: ObservableObject {

    @Published var selectedPlanIndex = 0

    let plans: [SubscriptionPlan] = [

        SubscriptionPlan(
            title: "Premium",
            trialPrice: "$4.99",
            trialDuration: "For first 2 weeks",
            regularPrice: "$19.99",
            billingCycle: "month",
            features: [
                "Unlimited Property Inquiries",
                "Full Deal Analysis & Reports",
                "Export Results as PDF",
                "Priority Support"
            ],
            isPopular: true
        ),

        SubscriptionPlan(
            title: "Pro",
            trialPrice: "$9.99",
            trialDuration: "For first 2 weeks",
            regularPrice: "$29.99",
            billingCycle: "month",
            features: [
                "Everything in Premium",
                "Unlimited Exports",
                "Advanced ROI Reports",
                "Investor Dashboard"
            ],
            isPopular: false
        )
    ]
}
