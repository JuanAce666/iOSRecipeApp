//
//  CartView.swift
//  RecipeApp
//
//  Created by Juan Felipe Acevedo Ramirez on 6/05/24.
//

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cartManager: CartManager
    @State private var showingCheckout = false

    var body: some View {
        ScrollView {
            VStack {
                if cartManager.products.count > 0 {
                    ForEach(cartManager.products, id: \.id) { product in
                        ProductRow(product: product)
                            .padding(.bottom, 8)
                    }
                    
                    HStack {
                        Text("Total:")
                            .font(.title2)
                        Spacer()
                        Text("$\(cartManager.total)")
                            .bold()
                            .font(.title)
                    }
                    .padding()
                    
                    PaymentButton(action: {})
                        .padding()

                    Button(action: {
                        showingCheckout = true
                    }) {
                        Text("Checkout")
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(12)
                    }
                    .padding()
                } else {
                    Spacer()
                    Text("Your cart is empty")
                        .font(.title)
                        .foregroundColor(.gray)
                    Spacer()
                }
            }
        }
        .navigationTitle("My Cart")
        .padding(.top)
        .sheet(isPresented: $showingCheckout) {
            if #available(iOS 17, *) {
                CheckoutPayment()
                    .environmentObject(cartManager)
                    .presentationDetents([.medium])
                    .presentationCornerRadius(30)
            } else {
                CheckoutPayment()
                    .environmentObject(cartManager)
                    .presentationDetents([.medium])
            }
        }
    }
}


#Preview {
    CartView()
        .environmentObject(CartManager())
}
