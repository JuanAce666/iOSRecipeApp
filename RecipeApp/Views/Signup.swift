//
//  Signup.swift
//  RecipeApp
//
//  Created by Juan Felipe Acevedo Ramirez on 7/05/24.
//

import SwiftUI

struct Signup: View {
    @Binding var showSignup: Bool
    @Binding var isAuthenticated: Bool
    @State private var emailID: String = ""
    @State private var fullName: String = ""
    @State private var password: String = ""
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var navigateToContentView: Bool = false

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 15) {
                Button(action: {
                    showSignup = false
                }, label: {
                    Image(systemName: "arrow.left")
                        .font(.title2)
                        .foregroundStyle(.gray)
                })
                .padding(.top, 20)
                
                Text("SignUp")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .padding(.top, 25)
                
                Text("Please sign up to continue")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundStyle(.gray)
                    .padding(.top, -5)
                
                VStack(spacing: 25) {
                    CustomTF(sfIcon: "at", hint: "Email ID", value: $emailID)
                    
                    CustomTF(sfIcon: "person", hint: "Full Name", value: $fullName)
                        .padding(.top, 5)
                    
                    CustomTF(sfIcon: "lock", hint: "Password", isPassword: true, value: $password)
                        .padding(.top, 5)
                    
                    GradientButton(title: "Continue", icon: "arrow.right") {
                        Task {
                            do {
                                try await viewModel.createUser(withEmail: emailID, password: password, fullname: fullName)
                                if viewModel.userSession != nil {
                                    navigateToContentView = true
                                    isAuthenticated = true
                                }
                            } catch {
                                print("Error creating user: \(error)")
                            }
                        }
                    }
                    .hSpacing(.trailing)
                    .disableWithOpacity(emailID.isEmpty || password.isEmpty || fullName.isEmpty)
                }
                .padding(.top, 20)
                
                Spacer(minLength: 0)
                
                HStack(spacing: 6) {
                    Text("Already have an account?")
                        .foregroundStyle(.gray)
                    
                    Button("Login") {
                        showSignup = false
                    }
                    .fontWeight(.bold)
                    .tint(.black)
                }
                .font(.callout)
                .hSpacing()
            }
            .padding(.vertical, 15)
            .padding(.horizontal, 25)
            .toolbar(.hidden, for: .navigationBar)
            .navigationDestination(isPresented: $navigateToContentView) {
                ContentView()
            }
        }
    }
}

extension Signup: AuthenticationFromProtocol {
    var formIsValid: Bool {
        return !emailID.isEmpty
        && emailID.contains("@")
        && !password.isEmpty
        && password.count > 5
        && !fullName.isEmpty
    }
}

#Preview {
    Signup(showSignup: .constant(true), isAuthenticated: .constant(false))
}

