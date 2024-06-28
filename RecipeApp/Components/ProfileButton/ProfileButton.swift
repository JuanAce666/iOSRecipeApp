//
//  ProfileButton.swift
//  RecipeApp
//
//  Created by Juan Felipe Acevedo Ramirez on 9/05/24.
//

import SwiftUI

struct ProfileButton: View {
    var body: some View {
            Image(systemName: "person.circle")
                .padding(.top, 5)
                .frame(width: 30, height: 30)
    }
}

#Preview {
    ProfileButton()
}
