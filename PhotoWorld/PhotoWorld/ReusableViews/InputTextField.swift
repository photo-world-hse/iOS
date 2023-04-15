//
//  InputTextField.swift
//  PhotoWorld
//
//  Created by Stepan Ostapenko on 15.04.2023.
//

import Foundation
import SwiftUI

enum InputTextFieldState {
    case valid
    case invalid
}

struct InputTextField: View {
    
    @Binding var text:  String
    @Binding var status: InputTextFieldState
    var placeholder: String
    
    var body: some View {
        HStack {
            TextField("input", text: $text)
                .font(FontScheme.kInterMedium(size: getRelativeHeight(14.0)))
                .foregroundColor(status == .valid ? ColorConstants.WhiteA700 : ColorConstants.Red400)
                .padding()
                .onChange(of: text, perform: { _  in status = .valid })
                .placeholder(when: text.isEmpty, placeholder: {
                    Text(placeholder).foregroundColor(Color.gray).padding()
                })
            if status != .valid {
                Image("inputError").padding()
            }
        }
        .frame(width: getRelativeWidth(343.0), height: getRelativeHeight(45.0), alignment: .center)
        .overlay(RoundedCorners(topLeft: 8.0, topRight: 8.0, bottomLeft: 8.0, bottomRight: 8.0)
                    .stroke(status == .valid ? ColorConstants.Bluegray800 : ColorConstants.Red400, lineWidth: 1))
        .background(RoundedCorners(topLeft: 8.0, topRight: 8.0, bottomLeft: 8.0,
                                   bottomRight: 8.0)
                        .fill(ColorConstants.Bluegray800))
    }
}
