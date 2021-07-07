//
//  MainCoordinator.swift
//  DietTestApp
//
//  Created by Maksym Horbenko on 06.07.2021.
//

import UIKit

final class MainCoordinator: Coordinator {
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController = UINavigationController()

    var mainTabBarController: MainTabBarViewController = MainTabBarViewController()

    func start() {
        let splashViewController = SplashViewController(
            contentView: SplashContentView(
                viewModel: SplashViewModel()
            )
        )
        
        splashViewController.segueActions = { [weak self] (action) in
            guard let self = self else { return }
            switch action {
            case .mainTab:
                self.configureAndShowMainTabViewController()
            }
        }
        
        navigationController.setNavigationBarHidden(true,
                                                    animated: false)
        navigationController.setViewControllers([splashViewController],
                                                animated: false)
    }
    
    // MARK: - Main Tab View Controller
    
    private func configureAndShowMainTabViewController(animated: Bool = true) {
        let feedCoordinator = FeedCoordinator()
        feedCoordinator.start()
        feedCoordinator.navigationController.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "icon_home_tab"), tag: 0)
        feedCoordinator.navigationController.tabBarItem.imageInsets = .init(top: 5, left: 0, bottom: -5, right: 0)
        
        let coachCoordinator = CoachCoordinator()
        coachCoordinator.start()
        coachCoordinator.navigationController.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "icon_coach_tab"), tag: 1)
        coachCoordinator.navigationController.tabBarItem.imageInsets = .init(top: 5, left: 0, bottom: -5, right: 0)

        let profileCoordinator = ProfileCoordinator()
        profileCoordinator.start()
        profileCoordinator.navigationController.tabBarItem = UITabBarItem(title: nil, image: #imageLiteral(resourceName: "icon_profile_tab"), tag: 2)
        profileCoordinator.navigationController.tabBarItem.imageInsets = .init(top: 5, left: 0, bottom: -5, right: 0)

        mainTabBarController.setViewControllers(
            [feedCoordinator.navigationController,
             coachCoordinator.navigationController,
             profileCoordinator.navigationController],
            animated: animated
        )
        
        navigationController.pushViewController(mainTabBarController, animated: animated)
    }
    
}
