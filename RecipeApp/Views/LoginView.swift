//
//  LoginView.swift
//  RecipeApp
//
//  Created by Juan Felipe Acevedo Ramirez on 7/05/24.
//

import SwiftUI
import FirebaseAuth
import GoogleSignIn
import GoogleSignInSwift
import Firebase

struct GoogleSignInresultModel {
    let idToken: String
    let accessToken: String
}

//MARK: - Auth Google
@MainActor
final class AuthenticationLoginView: ObservableObject {
    func signInGoogle() async throws {
        guard let topVC = Utilities.shared.getTopViewController() else  {
            throw URLError(.cannotFindHost)
        }
        
        let gidSignInResults = try await GIDSignIn.sharedInstance.signIn(withPresenting: topVC)
        
        guard let idToken = gidSignInResults.user.idToken?.tokenString else {
            throw URLError(.badServerResponse)
        }
        
        let accessToken = gidSignInResults.user.accessToken.tokenString
    
        let tokens = GoogleSignInresultModel(idToken: idToken, accessToken: accessToken)
        try await AuthViewModel.shared.signInWithGoogle(tokens: tokens)
    }
}

//MARK: - LoginView
struct LoginView: View {
    @StateObject private var viewModel2 = AuthenticationLoginView()
    @Binding var showSignup: Bool
    @Binding var isAuthenticated: Bool
    @State private var emailID: String = ""
    @State private var password: String = ""
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var showForgotPasswordView: Bool = false
    @State private var showResetView: Bool = false
    @State private var navigateToContentView: Bool = false

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 15) {
                Spacer(minLength: 0)
                
                Text("Login")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                
                Text("Please sign in to continue")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundStyle(.gray)
                    .padding(.top, -5)
                
                VStack(spacing: 25) {
                    CustomTF(sfIcon: "at", hint: "Email ID", value: $emailID)
                    
                    CustomTF(sfIcon: "lock", hint: "Password", isPassword: true, value: $password)
                        .padding(.top, 5)
                    
                    Button("Forgot Password?") {
                        showForgotPasswordView.toggle()
                    }
                    .font(.callout)
                    .fontWeight(.heavy)
                    .tint(.black)
                    .hSpacing(.trailing)
                    
                    // MARK: - SIGN IN BUTTON
                    GradientButton(title: "Login", icon: "arrow.right") {
                        Task {
                            do {
                                try await viewModel.singIn(withEmail: emailID, password: password)
                                if viewModel.userSession != nil {
                                    navigateToContentView = true
                                    isAuthenticated = true
                                }
                            } catch {
                                print("Error signing in: \(error)")
                            }
                        }
                    }
                    .disableWithOpacity(!formIsValid)
                    
                    //MARK: - Google button
                    
                    GoogleSignInButton(viewModel: GoogleSignInButtonViewModel(scheme: .light, style: .wide, state: .normal)) {
                        Task {
                            do {
                                try await viewModel2.signInGoogle()
                                showSignup = false
                            } catch {
                                print(error)
                            }
                        }
                    }
                    .padding()
                    .cornerRadius(10)
                    .shadow(radius: 5)

                }
                .padding(.top, 20)
                
                Spacer(minLength: 0)
                
                HStack(spacing: 6) {
                    Text("Don't have an account?")
                        .foregroundStyle(.gray)
                    
                    Button("Sign Up") {
                        showSignup.toggle()
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
            .sheet(isPresented: $showForgotPasswordView, content: {
                if #available(iOS 17, *) {
                    ForgotPassword(showResetView: $showResetView)
                        .presentationDetents([.height(300)])
                        .presentationCornerRadius(30)
                } else {
                    ForgotPassword(showResetView: $showResetView)
                        .presentationDetents([.height(300)])
                }
            })
            .sheet(isPresented: $showResetView, content: {
                if #available(iOS 17, *) {
                    PasswordResetView()
                        .presentationDetents([.height(350)])
                        .presentationCornerRadius(30)
                } else {
                    PasswordResetView()
                        .presentationDetents([.height(350)])
                }
            })
            .navigationDestination(isPresented: $navigateToContentView) {
                ContentView()
            }
        }
    }
}

extension LoginView: AuthenticationFromProtocol {
    var formIsValid: Bool {
        return !emailID.isEmpty
        && emailID.contains("@")
        && !password.isEmpty
        && password.count > 5
    }
}

#Preview{
    Group {
        LoginView(showSignup: .constant(true), isAuthenticated: .constant(true))
        LoginView(showSignup: .constant(true), isAuthenticated: .constant(false))
        LoginView(showSignup: .constant(false), isAuthenticated: .constant(false))
    }
}
