//
//  RecipeAppApp.swift
//  RecipeApp
//
//  Created by Juan Felipe Acevedo Ramirez on 6/05/24.
//

import SwiftUI
import Firebase

@main
struct RecipeAppApp: App {
    @AppStorage("signIn") var isSignIn = false
    
    @StateObject private var viewModel = AuthViewModel()
    @State private var isAuthenticated = false

    init() {
        FirebaseApp.configure()
        checkAuthentication()
    }
    
    func checkAuthentication() {
        if let _ = Auth.auth().currentUser {
            print("DEBUG: User is already authenticated")
            isAuthenticated = true
            isSignIn = true
        } else {
            print("DEBUG: No authenticated user")
            isAuthenticated = false
            isSignIn = false
        }
    }
    
    /*func checkAuthentication() {
        if let user = Auth.auth().currentUser {
            print("DEBUG: \(user.email ?? "unkowed") is already authenticated")
            isAuthenticated = true
        } else {
            print("DEBUG: no authenticated user")
            isAuthenticated = false
        }
    }*/

    var body: some Scene {
        WindowGroup {
            if isAuthenticated {
                ContentView()
                    .environmentObject(viewModel)
            } else {
                CircleAnimation(isAuthenticated: $isAuthenticated)
                    .environmentObject(viewModel)
            }
        }
    }
}

