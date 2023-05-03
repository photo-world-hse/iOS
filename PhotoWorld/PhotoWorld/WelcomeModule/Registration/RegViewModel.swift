//
//  RegViewModel.swift
//  PhotoWorld
//
//  Created by Stepan Ostapenko on 17.04.2023.
//

import Foundation
import UIKit

class RegViewModel: ObservableObject {
    internal init(moduleOutput: WelcomeModuleFlowCoordinatorOutput) {
        self.moduleOutput = moduleOutput
    }
    
    @Published var name = ""
    @Published var email = ""
    @Published var password = ""
    @Published var repeatPassword = ""
    @Published var passwordStatus = PasswordStatus.valid
    @Published var emailInputStatus = InputTextFieldState.valid
    @Published var rememberUser = false
    private let moduleOutput: WelcomeModuleFlowCoordinatorOutput
        
    func forgotPassword() {
        
    }
    
    func createAccount()  {
        if !StringValidator.isEmailValid(email) {
            emailInputStatus = .invalid("Неверный формат почты")
        }
        
        if !StringValidator.isPasswordValid(password) {
            passwordStatus = .weakPassword
        } else if password != repeatPassword {
            passwordStatus = .samePassword
        }
        
        if passwordStatus == .valid && emailInputStatus == .valid {
            moduleOutput.openAccountVerification()
        }
    }
    
    func logInWithGoogle() {
        
    }
    
    func goToLogIn() {
        moduleOutput.openLogin()
    }
}
