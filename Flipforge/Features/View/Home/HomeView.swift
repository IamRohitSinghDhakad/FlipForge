//
//  HomeView.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 22/06/26.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var vm = HomeViewModel()
    @EnvironmentObject var router: Router
    
    var body: some View {
        
        ZStack {
            
            Image(.loginBg)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                HomeHeaderView(
                    userName: vm.userName
                )
                .padding(.horizontal, 20)
                .padding(.top, 50)
                .padding(.bottom, 15)
                
                ScrollView(
                    showsIndicators: false
                ) {
                    
                    LazyVStack(
                        spacing: 16
                    ) {
                        
                        ForEach(vm.properties) { property in
                            
                            PropertyCardView(
                                property: property
                            ) {
                                
                                router.push(
                                    .propertyInquiry(
                                        .edit(property)
                                    )
                                )
                            }
                            onDelete: {

                                vm.propertyToDelete = property

                            }
                            onTap: {
//                                router.push(
//                                    .dealAnalysis(
//                                        PropertyResultModel.mock
//                                    )
//                                )
                            }
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.bottom, 120)
                }
            }
        }
        
        .alert(
            "Delete Property",
            isPresented: Binding(
                get: { vm.propertyToDelete != nil },
                set: { if !$0 { vm.propertyToDelete = nil } }
            )
        ) {

            Button("Cancel", role: .cancel) {
                vm.propertyToDelete = nil
            }

            Button("Delete", role: .destructive) {

                guard let property = vm.propertyToDelete else {
                    return
                }

                Task {
                   // await vm.deleteProperty(property)
                }

            }

        } message: {

            Text("Are you sure you want to delete this property?")
        }
        
        .alert(
            "Membership Required",
            isPresented: $vm.showMembershipAlert
        ) {

            Button("Take Membership") {

                router.push(.subscription)
            }

            Button("Cancel", role: .cancel) { }

        } message: {

            Text("Please take a membership first to continue.")
        }
        
        .onAppear {
            Task {
                await vm.loadData()
            }
        }
    }
}



#Preview {
    HomeView()
}
