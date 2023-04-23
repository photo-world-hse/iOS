//
//  WelcomeModuleFlowCoordinator.swift
//  PhotoWorld
//
//  Created by Stepan Ostapenko on 19.04.2023.
//

import Foundation
import UIKit
import SwiftUI

protocol WelcomeModuleFlowCoordinatorOutput {
    func openAccountVerification()
    func openLogin()
    func openRegistration()
    func openResetPasswordFlow()
}

extension FlowCoordinator {
    func createTitleLabel(title: String) -> UILabel {
        let label = UILabel()
        label.text = title
        label.textColor = UIColor(ColorConstants.WhiteA700)
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }
}

class WelcomeModuleFlowCoordinator: WelcomeModuleFlowCoordinatorOutput, CodeVerificationSuccessProtocol, FlowCoordinator {
    func CodeVerificationSuccess() {
        // Enter app
        print("Entering app")
    }
    
    var childCoordinators: [FlowCoordinator] = []
    var navigationController: UINavigationController
    var resolver: Resolver
    
    public init(navigationController: UINavigationController, resolver: Resolver) {
        self.navigationController = navigationController
        self.resolver = resolver
    }
    
    func start() {
        let loginVM = LoginViewModel(moduleOutput: self)
        let hostingVC = UIHostingController(rootView: LoginView(viewModel: loginVM))
        navigationController.setViewControllers([hostingVC], animated: false)
        
    }
    
    func openAccountVerification() {
        let verificationVM = VerificationViewModel(codeVerificationSuccess: self)
        let hostingVC = UIHostingController(rootView: AccountVerificationView(viewModel: verificationVM))
        hostingVC.navigationItem.titleView = createTitleLabel(title: "Код подтверждения")
        navigationController.pushViewController(hostingVC, animated: true)
    }
    
    func openLogin() {
        navigationController.popViewController(animated: true)
    }
    
    func openRegistration() {
        let regView = RegistrationView(viewModel: RegViewModel(moduleOutput: self))
        let hostingVC = UIHostingController(rootView: regView)
        hostingVC.navigationItem.setHidesBackButton(true, animated: false)
        navigationController.pushViewController(hostingVC, animated: true)
    }
    
    func openResetPasswordFlow() {
        let resetPasswordFlow = ResetPasswordFlowCoordinator(navigationController: navigationController)
        childCoordinators.append(resetPasswordFlow)
        resetPasswordFlow.start()
    }
}
