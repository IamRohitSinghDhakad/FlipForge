//
//  ForgotPasswordView.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 22/06/26.
//

import SwiftUI

struct ForgotPasswordView: View {
    
    @StateObject private var vm = ForgotPasswordViewModel()
    
    @EnvironmentObject var coordinator: AppCoordinator
    
    var body: some View {
        
        ZStack {
            
            Image(.loginBg)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
            CustomScreen {
                
                VStack {
                    
                    HStack {
                        
                        Button {
                            coordinator.showLogin()
                        } label: {
                            
                            Image(systemName: "chevron.left")
                                .font(.title2)
                                .foregroundColor(.white)
                        }
                        
                        Spacer()
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 50)
                    
                    Spacer()
                    
                    Image(.logo)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 180)
                    
                    forgotPasswordCard
                    
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    ForgotPasswordView()
}


extension ForgotPasswordView {
    
    private var forgotPasswordCard: some View {
        
        VStack(spacing: 24) {
            
            VStack(spacing: 10) {
                
                Text("Forgot Password")
                    .font(.system(size: 34, weight: .medium))
                    .foregroundColor(.white)
                
                Text("We will send new password on your registered email address")
                    .font(.system(size: 18))
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
            }
            
            CustomTextField(
                placeholder: "Email",
                icon: "envelope.fill",
                text: $vm.email
            )
            .keyboardType(.emailAddress)
            
            CustomButton(
                title: "SUBMIT"
            ) {
                
                vm.submit()
            }
        }
        .padding(30)
        .background(
            RoundedRectangle(cornerRadius: 35)
                .fill(
                    Color(
                        red: 10/255,
                        green: 39/255,
                        blue: 108/255
                    )
                )
        )
    }
}
