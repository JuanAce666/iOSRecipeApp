//
//  ProfileView.swift
//  RecipeApp
//
//  Created by Juan Felipe Acevedo Ramirez on 20/05/24.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationView {
            if let user = viewModel.currentUser {
                VStack {
                    Text(user.initials)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(width: 75, height: 75)
                        .background(Color(.systemGray3))
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(user.fullname)
                            .font(.subheadline)
                            .fontWeight(.bold)
                            
                        Text(user.email)
                            .font(.footnote)
                            .foregroundColor(.gray)
                    }
                    .padding()
                    
                    VStack {
                        Button(action: {
                            print("Sign Out button tapped")
                            viewModel.signOut()
                        }) {
                            HStack {
                                Image(systemName: "arrow.left.circle.fill")
                                Text("Sign Out")
                            }
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 30)
                            .background(Color.black)
                            .clipShape(Capsule())
                        }
                        
                        Button(action: {
                            Task {
                                print("Delete Account button tapped")
                                await viewModel.deleteAccount()
                            }
                        }) {
                            HStack {
                                Image(systemName: "xmark.circle.fill")
                                Text("Delete Account")
                            }
                            .foregroundColor(.white)
                            .padding(.vertical, 10)
                            .padding(.horizontal, 30)
                            .background(Color.black)
                            .clipShape(Capsule())
                        }
                    }
                    .padding()
                }
                .navigationTitle("Profile")
            } else {
                Text("User data not available")
                    .foregroundColor(.red)
                    .navigationTitle("Profile")
            }
        }
        .onAppear {
            print("ProfileView appeared")
        }
    }
}



struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(AuthViewModel())
    }
}
