//
//  Products.swift
//  RecipeApp
//
//  Created by Juan Felipe Acevedo Ramirez on 6/05/24.
//

import Foundation

struct Product: Identifiable {
    var id = UUID()
    var name: String
    var image: String
    var price: Int
}

var productList = [
    Product(name: "Adidas Campus ", image: "adidas campus", price: 2000),
    Product(name: "Nike SB", image: "Nike sb", price: 2400),
    Product(name: "Vans Potato", image: "vans potato", price: 3000),
    Product(name: "Pants Aestetic", image: "pants aest", price: 2300),
    Product(name: "Pants Flame", image: "pants flame", price: 1000),
    Product(name: "Pants Trash", image: "pants trash", price: 5000),
    Product(name: "Boxy Fit", image: "boxy fit", price: 4000),
    Product(name: "Heart Tshirt", image: "heart tshirt", price: 4000),
    Product(name: "Short Tshirt", image: "tshirt", price: 2000)
]
