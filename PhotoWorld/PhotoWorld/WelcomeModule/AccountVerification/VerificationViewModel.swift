//
//  VerificationViewModel.swift
//  PhotoWorld
//
//  Created by Stepan Ostapenko on 18.04.2023.
//

import Foundation
import SwiftUI

enum CodeEnterState {
    case editing
    case invalid
}

protocol CodeVerificationSuccessProtocol {
    func CodeVerificationSuccess()
}

class VerificationViewModel: ObservableObject {
    @Published var timeTillNewCode = 59
    @Published var codeEnterState = CodeEnterState.editing
    var insertedCode: String = "" {
        didSet {
            codeEnterState = .editing
        }
    }
    var email: String
    var timer: Timer?
    var codeVerificationSuccess: CodeVerificationSuccessProtocol
    
    public init(codeVerificationSuccess: CodeVerificationSuccessProtocol, email: String = "stepan@ostapenko.net") {
        self.codeVerificationSuccess = codeVerificationSuccess
        self.email = email
        createTimer()
    }
    
    func createTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                         target: self,
                                         selector: #selector(updateTimer),
                                         userInfo: nil,
                                         repeats: true)
    }
    
    @objc func updateTimer() {
        timeTillNewCode -= 1
    }
    
    func resetTimer() {
        timer?.invalidate()
        timer = nil
        timeTillNewCode = 59
        createTimer()
    }
    
    func requestNewCode() {
        resetTimer()
    }
    
    func sendCode() {
        // codeEnterState = .invalid
        codeVerificationSuccess.CodeVerificationSuccess()
    }
}
