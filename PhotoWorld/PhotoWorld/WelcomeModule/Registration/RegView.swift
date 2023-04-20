//
//  TestView.swift
//  PhotoWorld
//
//  Created by Stepan Ostapenko on 11.04.2023.
//

import Foundation
import SwiftUI

//Button(action: { print(1) }, label: {
//    HStack {
//        Image("img_group_red_500")
//            .resizable()
//            .frame(width: getRelativeWidth(18.0),
//                   height: getRelativeWidth(18.0), alignment: .leading)
//            .scaledToFit()
//            .clipped()
//            .padding(.vertical, getRelativeHeight(14.0))
//        Text("Создать аккаунт")
//    }
//})
//.buttonStyle(MainButtonStyle(backgoundColor: ColorConstants.WhiteA700, textColor: ColorConstants.BlueA700))

struct TestView: View {
    @State var input = ""
    @State var password = ""
    @State var repeatPassword = ""
    @State var passwordStatus = PasswordStatus.valid
    @State var email = ""
    @State var emailInputStatus = InputTextFieldState.valid
    @State var rememberUser = true
    
    var body: some View {
        
        VStack {
            InputTextField(text: $email, status: $emailInputStatus, placeholder: "email")
            PasswordTextField(password: $password, status: $passwordStatus)
            PasswordTextField(password: $repeatPassword, status: $passwordStatus)
            //Checkbox(value: rememberUser, info: "remember user")
            Toggle(isOn: $rememberUser) {
                Text("The label")
            }
            .toggleStyle(CheckboxStyle(size: .big))
//            Button(action: { emailInputStatus = .invalid }, label: {
//                Text("press")
//            }).buttonStyle(MainButtonStyle(backgoundColor: Color.red, textColor: Color.blue))
        }
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .background(ColorConstants.Bluegray900)
        .ignoresSafeArea()
    }
}



//HStack {
//    SecureField(StringConstants.kLbl10, text: $input)
//        .font(FontScheme.kInterMedium(size: getRelativeHeight(14.0)))
//        .foregroundColor(ColorConstants.Red400)
//        .padding()
//        .keyboardType(.default)
//    Image("img_vector")
//        .resizable()
//        .frame(width: getRelativeWidth(14.0),
//               height: getRelativeWidth(14.0), alignment: .center)
//        .scaledToFit()
//        .clipped()
//        .padding(.top, getRelativeHeight(13.0))
//        .padding(.bottom, getRelativeHeight(16.0))
//        .padding(.leading, getRelativeWidth(30.0))
//        .padding(.trailing, getRelativeWidth(17.0))
//    Spacer()
//}
//.frame(width: getRelativeWidth(343.0), height: getRelativeHeight(45.0),
//       alignment: .center)
//.overlay(RoundedCorners(topLeft: 8.0, topRight: 8.0, bottomLeft: 8.0,
//                        bottomRight: 8.0)
//        .stroke(ColorConstants.Red400,
//                lineWidth: 1))
//.background(RoundedCorners(topLeft: 8.0, topRight: 8.0, bottomLeft: 8.0,
//                           bottomRight: 8.0)
//        .fill(ColorConstants.Bluegray800))
