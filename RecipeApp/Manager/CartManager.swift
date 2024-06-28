//
//  CartManager.swift
//  RecipeApp
//
//  Created by Juan Felipe Acevedo Ramirez on 6/05/24.
//

import Foundation

class CartManager: ObservableObject {
    @Published private(set) var products: [Product] = []
    @Published private(set) var total: Int = 0
    
    func addToCart(product: Product) {
        products.append(product)
        total += product.price
    }
    
    func removeFromCart(product: Product) {
        products = products.filter { $0.id != product.id}
        total = products.reduce(0) {$0 + $1.price}
    }
}
