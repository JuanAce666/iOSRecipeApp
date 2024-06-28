//
//  View+Extensions.swift
//  RecipeApp
//
//  Created by Juan Felipe Acevedo Ramirez on 7/05/24.
//

import SwiftUI

extension View {
    @ViewBuilder
    func hSpacing(_ alignment: Alignment = .center) -> some View {
        self
            .frame(maxWidth: .infinity, alignment: alignment)
    }
    
    @ViewBuilder
    func vSpacing(_ alignment: Alignment = .center) -> some View {
        self
            .frame(maxHeight: .infinity, alignment: alignment)
    }
    
    //disable with opacity
    @ViewBuilder
    func disableWithOpacity(_ contidion: Bool) -> some View {
        self
            .disabled(contidion)
            .opacity(contidion ? 0.5 : 1)
    }
}
