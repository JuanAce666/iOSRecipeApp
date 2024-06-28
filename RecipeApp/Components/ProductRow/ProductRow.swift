//
//  ProductRow.swift
//  RecipeApp
//
//  Created by Juan Felipe Acevedo Ramirez on 6/05/24.
//

import SwiftUI

struct ProductRow: View {
    @EnvironmentObject var cartManager: CartManager
    var product: Product

    var body: some View {
        HStack(spacing: 16) {
            Image(product.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 80, height: 80)
                .cornerRadius(12)
                .shadow(radius: 3)

            VStack(alignment: .leading, spacing: 8) {
                Text(product.name)
                    .bold()
                    .font(.system(size: 18))

                Text("\(product.price) $")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()

            Button(action: {
                cartManager.removeFromCart(product: product)
            }) {
                Image(systemName: "trash.circle.fill")
                    .foregroundColor(.red)
                    .imageScale(.large)
            }
            .buttonStyle(BorderlessButtonStyle())
        }
        .padding()
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 3)
        .padding(.horizontal, 4)
    }
}

#Preview {
    ProductRow(product: productList[3])
        .environmentObject(CartManager())
}
