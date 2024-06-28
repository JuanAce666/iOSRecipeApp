//
//  CarButton.swift
//  RecipeApp
//
//  Created by Juan Felipe Acevedo Ramirez on 6/05/24.
//

import SwiftUI

struct CarButton: View {
    var numberOfProducts: Int
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image(systemName: "cart")
                .padding(.top, 5)
            
            if numberOfProducts > 0 {
                Text("\(numberOfProducts)")
                    .font(.caption2).bold()
                    .foregroundColor(.white)
                    .frame(width: 15, height: 15)
                    .background(.green)
                    .cornerRadius(50)
            }
        }
    }
}

#Preview {
    CarButton(numberOfProducts: 1)
}
