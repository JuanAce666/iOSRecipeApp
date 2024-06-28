//
//  ContentView.swift
//  RecipeApp
//
//  Created by Juan Felipe Acevedo Ramirez on 6/05/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var authViewModel: AuthViewModel
    @ObservedObject var cartManager = CartManager()
    @State private var searchText: String = ""
    var columns = [GridItem(.adaptive(minimum: 160), spacing: 20)]

    var body: some View {
        NavigationView {
            VStack {
                SearchBar(searchText: $searchText)
                ZStack {
                    if filteredProducts.isEmpty {
                        VStack {
                            Spacer()
                            Text("no products found")
                                .foregroundColor(.gray)
                                .padding()
                            Spacer()
                        }
                    } else {
                        ScrollView {
                            LazyVGrid(columns: columns, spacing: 20) {
                                ForEach(filteredProducts, id: \.id) { product in
                                    ProductCard(product: product)
                                        .environmentObject(cartManager)
                                        .transition(.opacity)
                                        .animation(.easeInOut(duration: 0.3), value: searchText)
                                }
                            }
                            .padding()
                        }
                    }
                }
            }
            .navigationTitle(Text("StreetWear"))
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink {
                        ProfileView()
                            .environmentObject(authViewModel)
                    } label: {
                        ProfileButton()
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink {
                        CartView()
                            .environmentObject(cartManager)
                    } label: {
                        CarButton(numberOfProducts: cartManager.products.count)
                    }
                }
            }
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }

    var filteredProducts: [Product] {
        if searchText.isEmpty {
            return productList
        } else {
            return productList.filter { product in
                product.name.lowercased().contains(searchText.lowercased())
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AuthViewModel())
    }
}
