//
//  CoachCoordinator.swift
//  DietTestApp
//
//  Created by Maksym Horbenko on 07.07.2021.
//

import UIKit

final class CoachCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController = UINavigationController()
    
    func start() {
        let vc = UIViewController()
        
        navigationController.setNavigationBarHidden(true,
                                                    animated: false)
        navigationController.setViewControllers([vc],
                                                animated: false)
    }
    
}
