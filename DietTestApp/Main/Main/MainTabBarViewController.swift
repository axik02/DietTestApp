//
//  MainTabBarViewController.swift
//  DietTestApp
//
//  Created by Maksym Horbenko on 07.07.2021.
//

import UIKit

final class MainTabBarViewController: UITabBarController {
    
    let customTabBar = CustomTabBar().apply {
        $0.barHeight = 89
    }
    
//    override var tabBar: UITabBar {
//        return customTabBar
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
        
    private func setupTabBar() {
        self.selectedIndex = 0
        self.tabBar.backgroundColor = .clear
        self.tabBar.barTintColor = .clear
        self.tabBar.backgroundImage = UIImage()
        self.tabBar.isTranslucent = true
        self.tabBar.tintColor = UIColor(hexString: "#FEC202")
        self.tabBar.unselectedItemTintColor = UIColor(hexString: "#979797")
    }

}

final class CustomTabBar: UITabBar {
    @IBInspectable var barHeight: CGFloat = 0.0

    override func sizeThatFits(_ size: CGSize) -> CGSize {
        var sizeThatFits = super.sizeThatFits(size)
        if barHeight > 0.0 {
            sizeThatFits.height = barHeight
        }
        return sizeThatFits
    }
}
