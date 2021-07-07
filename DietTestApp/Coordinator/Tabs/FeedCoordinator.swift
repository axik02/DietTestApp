//
//  FeedCoordinator.swift
//  DietTestApp
//
//  Created by Maksym Horbenko on 07.07.2021.
//

import UIKit

final class FeedCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController = UINavigationController()

    func start() {
        let vc = FeedViewController(
            contentView: FeedContentView(
                viewModel: FeedViewModel()
            )
        )
        
        navigationController.setNavigationBarHidden(true,
                                                    animated: false)
        navigationController.setViewControllers([vc],
                                                animated: false)
    }
    
}
