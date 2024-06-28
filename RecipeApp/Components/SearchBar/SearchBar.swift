//
//  SearchBar.swift
//  RecipeApp
//
//  Created by Juan Felipe Acevedo Ramirez on 8/05/24.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String 
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            TextField("Search Products", text: $searchText)
                .padding(7)
                .background(Color(.systemGray6))
                .cornerRadius(8)
        }
        .padding()
    }
}
