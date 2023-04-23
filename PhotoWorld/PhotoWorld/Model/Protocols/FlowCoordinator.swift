//
//  FlowCoordinator.swift
//  PhotoWorld
//
//  Created by Stepan Ostapenko on 19.04.2023.
//

import Foundation
import UIKit

protocol FlowCoordinator {
    var childCoordinators: [FlowCoordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
