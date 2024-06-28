//
//  CircleAnimation.swift
//  RecipeApp
//
//  Created by Juan Felipe Acevedo Ramirez on 7/05/24.
//

import SwiftUI

struct CircleAnimation: View {
    @State private var showSignup: Bool = false
    @Binding var isAuthenticated: Bool
    var body: some View {
        NavigationStack {
            LoginView(showSignup: $showSignup, isAuthenticated: $isAuthenticated)
                .navigationDestination(isPresented: $showSignup) {
                    Signup(showSignup: $showSignup, isAuthenticated: $isAuthenticated)
                }
        }
        .overlay {
            if #available(iOS 17, *) {
                CircleView()
                    .animation(.smooth(duration: 0.45, extraBounce: 0), value: showSignup)
            } else {
                CircleView()
                    .animation(.easeInOut(duration: 0.3), value: showSignup)
            }
        }
    }
    @ViewBuilder
    func CircleView() -> some View {
        Circle()
            .fill(.linearGradient(colors: [.gray,.black,.black], startPoint: .top, endPoint: .bottom))
            .frame(width: 200, height: 200)
            .offset(x: showSignup ? 90: -90, y: -90)
            .blur(radius: 15)
            .hSpacing(showSignup ? .trailing : .leading)
            .vSpacing(.top)
    }
}

#Preview {
    CircleAnimation(isAuthenticated: .constant(false))
}
