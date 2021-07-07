//
//  SplashViewController.swift
//  DietTestApp
//
//  Created by Maksym Horbenko on 06.07.2021.
//

import UIKit

enum SplashViewControllerSegue {
    case mainTab
}

final class SplashViewController: ViewController<SplashContentView> {

    var segueActions: ((SplashViewControllerSegue) -> Void)?
    
    override func configure() {
        super.configure()
    }

    override func actions() {
        super.actions()
        
        contentView.viewModel.actions = { [weak self] action in
            guard let self = self else { return }
            switch action {
            case .perform(let segue):
                self.segueActions?(segue)
            }
        }
    }

    override func notifies() {
        super.notifies()
        
        contentView.viewModel.state = { [weak self] state in
            guard let self = self else { return }
            
            switch state {
            case .loading:
                self.contentView.displayAnimatedActivityIndicatorView(color: .white, style: .large)
            case .none:
                self.contentView.hideAnimatedActivityIndicatorView()
            }
        }
    }
}
