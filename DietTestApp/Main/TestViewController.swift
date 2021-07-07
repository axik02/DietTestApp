//
//  SplashViewController.swift
//  DietTestApp
//
//  Created by Maksym Horbenko on 06.07.2021.
//

import UIKit

class SplashViewController: ViewController<SplashContentView> {

    override func configure() {
        super.configure()
    }

    override func actions() {
        super.actions()
    }

    override func notifies() {
        super.notifies()
        
        contentView.viewModel.state = { state in
            switch state {
            case .load:
                print("load state")
            }
        }
    }
}
