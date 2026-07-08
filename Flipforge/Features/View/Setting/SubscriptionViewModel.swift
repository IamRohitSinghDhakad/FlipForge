//
//  SubscriptionViewModel.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 23/06/26.
//

import Foundation
import Combine

@MainActor
final class SubscriptionViewModel: BaseViewModel {

    private let repository: AuthRepositoryProtocol

    @Published var isLoading = false
    @Published var isSubscribed = false

    init(
        repository: AuthRepositoryProtocol = AuthRepository()
    ) {
        self.repository = repository
    }

    let plan = SubscriptionPlan(
        title: "Premium Plan",
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
        isPopular: false
    )

    func checkSubscription() async {

        isLoading = true
        defer { isLoading = false }

        do {

            let response = try await repository.activeSubscription(
                userId: UserSession.userId
            )

            let subscribed =
            !(response.result?.subscription_id ?? "").isEmpty

            isSubscribed = subscribed

            UserSession.paymentStatus = subscribed ? "1" : "0"

        } catch {

            isSubscribed = false
            UserSession.paymentStatus = "0"
        }
    }
}
