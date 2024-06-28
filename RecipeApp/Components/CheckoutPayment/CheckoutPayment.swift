//
//  CheckoutPayment.swift
//  RecipeApp
//
//  Created by Juan Felipe Acevedo Ramirez on 9/05/24.
//

import SwiftUI

struct CheckoutPayment: View {
    @EnvironmentObject var cartManager: CartManager
    @State private var deliveryAddress: String = ""
    @State private var paymentMethod: String = ""
    @State private var promoCode: String = ""
    @State private var showAlert = false
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            Button(action: {
                dismiss()
            }, label: {
                Image(systemName: "xmark")
                    .font(.title2)
                    .foregroundStyle(.gray)
            })
            .padding(.top, 20)
            
            Text("Checkout")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding(.top, 10)
            
            CustomTF(sfIcon: "house", hint: "Delivery Address", value: $deliveryAddress)
                .padding(.top, 20)
            
            CustomTF(sfIcon: "creditcard", hint: "Payment Method", value: $paymentMethod)
                .padding(.top, 20)
            
            CustomTF(sfIcon: "tag", hint: "Promo Code", value: $promoCode)
                .padding(.top, 20)
        
            GradientButton(title: "Place Order", icon: "arrow.right") {
                showAlert = true
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Order Completed"), message: Text("Your order has been placed successfully."), dismissButton: .default(Text("OK")))
            }
            .padding(.top, 20)
        }
        .padding(.vertical, 15)
        .padding(.horizontal, 25)
        .frame(maxWidth: .infinity)
        .cornerRadius(20)
        .interactiveDismissDisabled()
    }
}

#Preview {
    CheckoutPayment()
}
