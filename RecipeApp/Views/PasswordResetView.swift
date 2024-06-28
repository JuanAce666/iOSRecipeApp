//
//  PasswordResetView.swift
//  RecipeApp
//
//  Created by Juan Felipe Acevedo Ramirez on 7/05/24.
//

import SwiftUI

struct PasswordResetView: View {
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Button(action: {
                dismiss()
            }, label: {
                Image(systemName: "xmark")
                    .font(.title2)
                    .foregroundStyle(.gray)
            })
            .padding(.top, 20)
            Text("Reset Password?")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.top, 10)
            
            VStack(spacing: 25) {
                CustomTF(sfIcon: "lock", hint: "Password",isPassword: true, value: $password)
                
                CustomTF(sfIcon: "lock", hint: "Confirm Password",isPassword: true ,value: $confirmPassword)
            
                GradientButton(title: "Send Link", icon: "arrow.right") {

                }
                .hSpacing(.trailing)
                .disableWithOpacity(password.isEmpty || confirmPassword.isEmpty)
            }
            .padding(.top, 20)
        }
        .padding(.vertical, 15)
        .padding(.horizontal, 25)
        .interactiveDismissDisabled()
    }
}

#Preview {
    LoginView(showSignup: .constant(true), isAuthenticated: .constant(false))
}
