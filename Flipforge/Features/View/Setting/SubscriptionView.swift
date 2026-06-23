//
//  SubscriptionView.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 23/06/26.
//

import SwiftUI

struct SubscriptionView: View {

    @StateObject private var vm =
    SubscriptionViewModel()

    @EnvironmentObject var router: Router

    var body: some View {

        ZStack {

            Image(.loginBg)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            VStack(spacing: 0) {

                CustomNavigationBar(
                    title: "Subscription",
                    subtitle: nil
                ) {
                    router.pop()
                }

                ScrollView(
                    showsIndicators: false
                ) {

                    VStack(spacing: 24) {

                        headerSection

                        plansSection

                        subscribeButton

                        Text(
                            "Cancel anytime. No hidden charges."
                        )
                        .foregroundColor(.gray)
                        .padding(.bottom, 40)
                    }
                    .padding()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}


private extension SubscriptionView {

    var headerSection: some View {

        VStack(spacing: 16) {

            Image(systemName: "crown.fill")
                .font(.system(size: 70))
                .foregroundColor(.orange)

            Text("Premium Plans")
                .font(.system(size: 34, weight: .bold))
                .foregroundColor(.white)

            Text(
                "Unlock all features and grow your real estate business"
            )
            .font(.system(size: 18))
            .foregroundColor(.gray)
            .multilineTextAlignment(.center)
        }
    }
}

private extension SubscriptionView {

    var plansSection: some View {

        TabView(
            selection: $vm.selectedPlanIndex
        ) {

            ForEach(
                Array(vm.plans.enumerated()),
                id: \.offset
            ) { index, plan in

                SubscriptionCard(
                    plan: plan
                )
                .padding(.horizontal, 8)
                .tag(index)
            }
        }
        .frame(height: 520)
        .tabViewStyle(
            .page(indexDisplayMode: .automatic)
        )
    }
}

private extension SubscriptionView {

    var subscribeButton: some View {

        CustomButton(
            title: "SUBSCRIBE NOW"
        ) {

            let selectedPlan =
            vm.plans[vm.selectedPlanIndex]

            print(selectedPlan.title)
            
            // RevenueCat Purchase
        }
    }
}
