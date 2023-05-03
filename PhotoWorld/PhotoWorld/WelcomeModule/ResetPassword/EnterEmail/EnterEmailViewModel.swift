//
//  EnterEmailViewModel.swift
//  PhotoWorld
//
//  Created by Stepan Ostapenko on 19.04.2023.
//

import Foundation

class EnterEmailViewModel: ObservableObject {
    internal init(resetPasswordModuleOutput: ResetPasswordModuleOutput) {
        self.resetPasswordModuleOutput = resetPasswordModuleOutput
    }
    
    @Published var email = ""
    @Published var emailInputState: InputTextFieldState = .valid
    private let resetPasswordModuleOutput: ResetPasswordModuleOutput
    
    func sendCode() {
        resetPasswordModuleOutput.commmitEmail(email: email)
    }
}
