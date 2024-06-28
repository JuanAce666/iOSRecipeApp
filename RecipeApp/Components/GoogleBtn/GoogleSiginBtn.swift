//
//  GoogleSiginBtn.swift
//  RecipeApp
//
//  Created by Juan Felipe Acevedo Ramirez on 13/06/24.
//

import SwiftUI

struct GoogleSignInBtn: View {
    var action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            ZStack {
                Circle()
                    .foregroundColor(.white)
                    .shadow(color: .gray, radius: 6, x: 0, y: 2)

                Image("google")
                    .resizable()
                    .scaledToFit()
                    .mask(Circle())
            }
        }
        .frame(width: 50, height: 50)
    }
}

struct GoogleSignInBtn_Previews: PreviewProvider {
    static var previews: some View {
        GoogleSignInBtn(action: {})
    }
}
