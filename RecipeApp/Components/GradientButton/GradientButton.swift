//
//  GradientButton.swift
//  RecipeApp
//
//  Created by Juan Felipe Acevedo Ramirez on 7/05/24.
//

import SwiftUI

struct GradientButton: View {
    var title: String
    var icon: String
    var onClick: () -> ()
    
    var body: some View {
        Button(action: onClick) {
            HStack(spacing: 10) {
                Text(title)
                    .fontWeight(.medium)
                Image(systemName: icon)
            }
            .foregroundColor(.white)
            .padding(.vertical, 10)
            .padding(.horizontal, 30)
            .background(Color.black)
            .clipShape(Capsule())
        }
    }
}

#Preview {
    GradientButton(title: "Button", icon: "arrow.right", onClick: {})
    .previewLayout(.sizeThatFits)
}
