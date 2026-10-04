//
//  SettingView.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 23/06/26.
//

import SwiftUI

struct SettingsView: View {

    @StateObject private var vm = SettingsViewModel()
    @EnvironmentObject var coordinator: AppCoordinator
    @EnvironmentObject var router: Router
    @Environment(\.openURL) private var openURL
    @State private var showDeleteAlert = false

    var body: some View {

        ZStack {

            ScrollView(showsIndicators: false) {

                VStack(spacing: 18) {

                    Text("Settings")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.white)
                        .padding(.top, 60)

                    ProfileCardView(
                        profile: vm.profile
                    )

                    SettingsRow(
                        icon: "gearshape.fill",
                        title: "Master Settings"
                    ) {
                        router.push(
                            .masterSettings
                        )
                    }

                    if UserSession.isSubscribed {
                        SettingsRow(
                            icon: "crown.fill",
                            title: "Subscription"
                        ) {
                            router.push(.subscription)
                        }
                    }

                    SettingsRow(
                        icon: "shield.fill",
                        title: "Privacy Policy"
                    ) {
                        router.push(
                            .webPage(
                                title: "Privacy Policy",
                                url: APIConstants.privacyPolicyURL
                            )
                        )
                    }

                    SettingsRow(
                        icon: "envelope.fill",
                        title: "Contact With Email"
                    ) {

                        guard let url = URL(
                            string: "mailto:flipforgehelp@gmail.com?subject=FlipForge%20Support&body=Hi%20FlipForge%20Team,"
                        ) else {
                            return
                        }

                        openURL(url)

                    }

                    DangerSettingsRow(
                        icon: "trash",
                        title: "Delete Account"
                    ) {
                        showDeleteAlert = true
                    }

                    DangerSettingsRow(
                        icon: "rectangle.portrait.and.arrow.right",
                        title: "Logout"
                    ) {

                        UserSession.logout()
                        coordinator.showLogin()
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 120)
            }
        }.alert(
            "Error",
            isPresented: $vm.showAlert
        ) {
            Button("OK", role: .cancel) { }
        } message: {
            Text(vm.alertMessage)
        }
        
        .background(
            BackgroundView()
        )
        
        
        .alert(
            "Delete Account",
            isPresented: $showDeleteAlert
        ) {

            Button(
                "Delete",
                role: .destructive
            ) {
                Task {
                    let success = await vm.deleteAccount()

                    if success {
                        coordinator.showLogin()
                    }
                }
            }

            Button(
                "Cancel",
                role: .cancel
            ) { }

        } message: {

            Text(
                "Are you sure you want to delete your account?\n\nThis action is permanent and cannot be undone. All your data will be permanently removed."
            )
        }
        
        .onAppear{
            Task{
                await vm.loadProfile()
            }
            
        }
    }
}



struct SettingsRow: View {

    let icon: String
    let title: String
    let action: () -> Void

    var body: some View {

        Button(action: action) {

            HStack {

                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(.blue)
                    .frame(width: 35)

                Text(title)
                    .font(.title3)
                    .foregroundColor(.white)

                Spacer()

                Image(systemName: "chevron.right")
                    .foregroundColor(.white)
            }
            .padding()
            .background(
                RoundedRectangle(
                    cornerRadius: 24
                )
                .fill(
                    Color(
                        red: 17/255,
                        green: 49/255,
                        blue: 109/255
                    )
                )
            )
        }
    }
}


struct DangerSettingsRow: View {

    let icon: String
    let title: String
    let action: () -> Void

    var body: some View {

        Button(action: action) {

            HStack {

                Image(systemName: icon)
                    .font(.title2)
                    .foregroundColor(.orange)
                    .frame(width: 35)

                Text(title)
                    .font(.title3)
                    .foregroundColor(.orange)

                Spacer()
            }
            .padding()
            .background(
                RoundedRectangle(
                    cornerRadius: 24
                )
                .fill(
                    Color(
                        red: 17/255,
                        green: 49/255,
                        blue: 109/255
                    )
                )
            )
        }
    }
}
