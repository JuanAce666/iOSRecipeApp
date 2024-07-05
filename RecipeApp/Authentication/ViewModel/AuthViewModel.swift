//
//  AuthViewModel.swift
//  RecipeApp
//
//  Created by Juan Felipe Acevedo Ramirez on 17/05/24.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import FirebaseAuth

protocol AuthenticationFromProtocol {
    var formIsValid: Bool {get}
}

@MainActor
class AuthViewModel: ObservableObject {
    static let shared = AuthViewModel()
    @Published var userSession: FirebaseAuth.User?
    @Published var currentUser: User?
    
    init() {
        self.userSession = Auth.auth().currentUser
        Task {
            await fetchUser()
        }
    }
    
    func singIn(withEmail email: String, password: String) async throws {
        do {
            let result = try await Auth.auth().signIn(withEmail: email, password: password)
            self.userSession = result.user
            await fetchUser()
        }catch {
            print("DEBUG: Failed to log in with error \(error.localizedDescription)")
        }
    }
    
    func createUser(withEmail email: String, password: String, fullname: String ) async throws {
        do {
            let result = try await Auth.auth().createUser(withEmail: email, password: password)
            self.userSession = result.user
            let user = User(id: result.user.uid, fullname: fullname, email: email)
            let encoderUser = try Firestore.Encoder().encode(user)
            try await Firestore.firestore().collection("users").document(user.id).setData(encoderUser)
            await fetchUser()
        }catch {
            print("DEBUG: failed to create user with error \(error.localizedDescription)")
        }
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
            print("DEBUG: Successfully signed out")
        } catch let error as NSError {
            print("DEBUG: Failed to sign out with error \(error.localizedDescription)")
        }
    }
    
    func deleteAccount() async {
        guard let user = Auth.auth().currentUser else {
            print("DEBUG: No user to delete")
            return
        }
        do {
            try await Firestore.firestore().collection("users").document(user.uid).delete()
            try await user.delete()
            try Auth.auth().signOut()
            self.userSession = nil
            self.currentUser = nil
            print("DEBUG: Account delete successful")
        } catch let error as NSError {
            print("DEBUG: Error with delete account: \(error.localizedDescription)")
        }
    }


    
   /* func deleteAccount() async {
        guard let user = Auth.auth().currentUser else {
            print("DEBUG: No user to delete")
            return
        }
        do {
            try await Firestore.firestore().collection("users").document(user.uid).delete()
            try await user.delete()
            self.userSession = nil
            self.currentUser = nil
            print("DEBUG account delete successful")
        }catch {
            print("DEBUG: Error with delete account: \(error.localizedDescription)" )
        }
    } */
    
    func fetchUser() async {
        guard let uid = Auth.auth().currentUser?.uid else {return}
        guard let snapshot = try? await Firestore.firestore().collection("users").document(uid).getDocument() else {return}
        self.currentUser = try? snapshot.data(as: User.self)
    }
}

// MARK: - SignIn sso
extension AuthViewModel {
    func signInWithGoogle(tokens: GoogleSignInresultModel) async throws {
        let credential = GoogleAuthProvider.credential(withIDToken: tokens.idToken, accessToken: tokens.accessToken)
        print("DEBUG: Google ID Token: \(tokens.idToken)")
        print("DEBUG: Google Access Token: \(tokens.accessToken)")
        try await signIn(credential: credential)
    }
    
    func signIn(credential: AuthCredential) async throws {
        do {
            let authDataResult = try await Auth.auth().signIn(with: credential)
            self.userSession = authDataResult.user
            print("DEBUG: Firebase User: \(authDataResult.user.uid)")
            await fetchUser()
        } catch {
            print("DEBUG: Error signing in with Google: \(error.localizedDescription)")
        }
    }
}
