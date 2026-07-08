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

                        if vm.isLoading {

                            ProgressView()
                                .tint(.white)
                                .padding(.vertical, 20)

                        } else if vm.isSubscribed {

                            VStack(spacing: 10) {

                                Image(systemName: "checkmark.seal.fill")
                                    .font(.system(size: 45))
                                    .foregroundColor(.green)

                                Text("You are already subscribed")
                                    .font(.headline)
                                    .foregroundColor(.green)
                            }

                        } else {

                            plansSection
                            
                            subscribeButton
                        }
                       
                    }
                    .padding()
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        
        .onAppear{
            Task{
                await vm.checkSubscription()
            }
            
        }
    }
}


private extension SubscriptionView {

    var headerSection: some View {

        VStack(spacing: 16) {

            Image(systemName: "crown.fill")
                .font(.system(size: 70))
                .foregroundColor(.orange)

            Text("Premium Plan")
                .font(.system(size: 34, weight: .bold))
                .foregroundColor(.white)

            
            
            Text(
                vm.isSubscribed
                ? "Your Premium Plan is Active. Enjoy all premium features and grow your real estate business."
                : "Unlock all features and grow your real estate business."
            )
            .font(.system(size: 18))
            .foregroundColor(.gray)
            .multilineTextAlignment(.center)
        }
    }
}

private extension SubscriptionView {

    var plansSection: some View {

        SubscriptionCard()
            .padding(.horizontal, 8)
    }
}

private extension SubscriptionView {

    var subscribeButton: some View {

        CustomButton(
            title: "SUBSCRIBE NOW"
        ) {
            router.push(
                .subscriptionCheckout(
                    url:  APIConstants.baseURL + "subscribe?user_id=\(UserSession.userId)"
                )
            )
        }
    }
}
