//
//  ViewController.swift
//  PhotoWorld
//
//  Created by Stepan Ostapenko on 15.04.2023.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let hosting = UIHostingController(rootView: TestView())
        navigationController?.pushViewController(hosting, animated: true)
    }
}
