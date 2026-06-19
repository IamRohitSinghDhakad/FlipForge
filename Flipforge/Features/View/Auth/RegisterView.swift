//
//  RegisterView.swift
//  Flipforge
//
//  Created by Rohit SIngh Dhakad on 19/06/26.
//

import SwiftUI


struct RegisterView: View {

    @StateObject private var vm = RegisterViewModel()
    @EnvironmentObject var coordinator: AppCoordinator

    var body: some View {

        ZStack {

            Image(.loginBg)
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()

            CustomScreen {

                VStack(spacing: 0) {

                    // Navigation Bar
                    CustomNavigationBar(
                        title: "Create Account",
                        subtitle: "Fill in the details to get started"
                    ) {
                        coordinator.showLogin()
                    }
                    .padding(.top, 30)

                    // Content
                    VStack(spacing: 18) {

                        ProfileImagePicker(
                            image: $vm.profileImage
                        )
                        .frame(width: 130, height: 130)

                        Text("Add Profile Picture")
                            .font(.headline)
                            .foregroundColor(.orange)

                        formSection

                        PasswordRulesView()

                        CustomButton(
                            title: "REGISTER"
                        ) {
                            vm.register()
                        }

                        loginSection
                            .padding(.bottom, 20)
                    }
                    .padding(.horizontal, 24)
                    .padding(.top, 20)
                }
            }
        }
    }
}

#Preview {
    RegisterView()
}

struct ProfileImagePicker: View {

    @Binding var image: UIImage?

    var body: some View {

        CustomImagePicker(selectedImage: $image)
            .frame(width: 140, height: 140)
            .background(
                Circle()
                    .fill(Color.clear)
            )
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(Color.white, lineWidth: 2)
            )
    }
}


struct PasswordRulesView: View {

    var body: some View {

        VStack(
            alignment: .leading,
            spacing: 8
        ) {

            Text("Password must contain:")

            Text("✓ At least 8 characters")
            Text("✓ One uppercase letter")
            Text("✓ One lowercase letter")
            Text("✓ One number")
            Text("✓ One special character")
        }
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}


extension RegisterView {

    var formSection: some View {

           VStack(spacing: 20) {

               CustomTextField(
                   placeholder: "Full Name",
                   icon: "person",
                   text: $vm.fullName
               )

               CustomTextField(
                   placeholder: "Email",
                   icon: "envelope.fill",
                   text: $vm.email
               )

               CustomSecureField(
                   placeholder: "Password",
                   text: $vm.password
               )

               CustomSecureField(
                   placeholder: "Confirm Password",
                   text: $vm.confirmPassword
               )
           }
       }
    
    
    var loginSection: some View {

           HStack(spacing: 5) {

               Text("Already have an account?")
                   .foregroundColor(.white)

               Button {
                   coordinator.showLogin()

               } label: {

                   Text("Login")
                       .foregroundColor(.white)
                       .fontWeight(.semibold)
               }
           }
       }
}
