//
//  CustomTF.swift
//  RecipeApp
//
//  Created by Juan Felipe Acevedo Ramirez on 7/05/24.
//

import SwiftUI

struct CustomTF: View {
    var sfIcon: String
    var iconTint: Color = .gray
    var hint: String
    var isPassword: Bool = false
    @Binding var value: String
    @State private var showPassword: Bool = false

    var body: some View {
        HStack(alignment: .top,spacing: 8 ,content: {
            Image(systemName: sfIcon)
                .foregroundStyle(iconTint)
                .frame(width: 30)
                .offset(y: 2)
            
            VStack(alignment: .leading,spacing: 8 ,content: {
                if isPassword {
                    Group {
                        if showPassword {
                            TextField(hint, text: $value)
                        }else {
                            SecureField(hint, text: $value)
                        }
                    }
                }else {
                    TextField(hint, text: $value)
                }
                Rectangle()
                    .background(Color.black)
                    .shadow(color: .black, radius: 2)
                    .frame(height: 0.5)
                    .blur(radius: 0.5)
            })
            .overlay(alignment: .trailing) {
                if isPassword {
                    Button(action: {
                        withAnimation {
                            showPassword.toggle()
                        }
                    }, label: {
                        Image(systemName: showPassword ? "eye.slash" : "eye")
                            .foregroundStyle(.gray)
                            .padding(10)
                            .contentShape(.rect)
                    })
                }
            }
        })
    }
}

