//
//  EnterCodeViewModel.swift
//  PhotoWorld
//
//  Created by Stepan Ostapenko on 19.04.2023.
//

import Foundation

class EnterNewPasswordViewModel: ObservableObject {
    internal init(resetPasswordModuleOutput: ResetPasswordModuleOutput) {
        self.resetPasswordModuleOutput = resetPasswordModuleOutput
    }
    
    @Published var password = ""
    @Published var repeatPassword = ""
    @Published var passwordStatus = PasswordStatus.valid
    private let resetPasswordModuleOutput: ResetPasswordModuleOutput
    
    func canSend() -> Bool {
        return !password.isEmpty && !repeatPassword.isEmpty && passwordStatus == .valid
    }
    
    func checkPasswords() {
        
    }
    
    func sendPassword() {
        checkPasswords()
        resetPasswordModuleOutput.changePasswordSuccess()
    }
}
