//
//  LoginViewModel.swift
//  PhotoWorld
//
//  Created by Stepan Ostapenko on 18.04.2023.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    @Published var email = ""
    @Published var password = ""
    @Published var passwordStatus = PasswordStatus.valid
    @Published var emailInputStatus = InputTextFieldState.valid
    @Published var rememberUser = false

    private let moduleOutput: WelcomeModuleFlowCoordinatorOutput
    
    internal init(moduleOutput: WelcomeModuleFlowCoordinatorOutput) {
        self.moduleOutput = moduleOutput
    }
    
    func forgotPassword() {
        moduleOutput.openResetPasswordFlow()
    }
    
    func createAccount()  {
        moduleOutput.openRegistration()
    }
    
    func logInWithGoogle() {
        
    }
    
    func logIn() {
        if !StringValidator.isEmailValid(email) {
            emailInputStatus = .invalid("Неверный формат почты")
        }
    }
}
