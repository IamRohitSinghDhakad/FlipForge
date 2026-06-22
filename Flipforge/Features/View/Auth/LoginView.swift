//
//  LoginView.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 19/06/26.
//

import SwiftUI


struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var isSecure = true
    @FocusState private var focusedField: Field?
    @EnvironmentObject var coordinator: AppCoordinator
    
    var body: some View {
        
        ZStack {
            
            // Background
            Image(.loginBg)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
            
           CustomScreen {
                
                VStack {
                    
                    Spacer()
                    
                    // Logo
                    Image(.logo)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 180)
                    
                    Spacer()
                    
                    loginCard
                        .padding(.bottom, 80)
                }
                .padding(.bottom, 30)
            }
        }
        .hideKeyboardOnTap()
    }
}

#Preview {
    LoginView()
}


extension LoginView {
    
    private var loginCard: some View {
        
        VStack(spacing: 24) {
            
            VStack(spacing: 10) {
                
                Text("Welcome Back!")
                    .font(.system(size: 38, weight: .medium))
                    .foregroundStyle(Color.white)
                
                Text("Login to your account")
                    .font(.system(size: 20))
                    .foregroundColor(.gray)
            }
            
            VStack(spacing: 20) {
                
                CustomTextField(
                    placeholder: "Email",
                    icon: "envelope.fill",
                    text: $email
                )
                .focused($focusedField, equals: .email)
                .submitLabel(.next)
                .onSubmit {
                    focusedField = .password
                }
                
                CustomSecureField(
                    placeholder: "Password",
                    text: $password
                )
                .focused($focusedField, equals: .password)
                .submitLabel(.done)
                .onSubmit {
                    focusedField = nil
                }
                
                
            }
            
            HStack {
                
                Button {
                    coordinator.showForgotPassword()
                } label: {
                    
                    Text("Forgot Password?")
                        .foregroundColor(.orange)
                        .font(.system(size: 18))
                }
                
                Spacer()
            }
            
            CustomButton(title: "LOGIN") {
                coordinator.showMainTab()
            }
            
            HStack(spacing: 5) {
                
                Text("Don't have an account?")
                    .foregroundColor(.white)
                
                Button {
                    coordinator.showRegister()
                } label: {
                    
                    Text("Register")
                        .foregroundColor(.white)
                        .fontWeight(.semibold)
                }
            }
        }
        .padding(30)
        .background(
            RoundedRectangle(cornerRadius: 35)
                .fill(Color(red: 10/255,
                            green: 39/255,
                            blue: 108/255))
        )
        .padding(.horizontal, 20)
    }
}



