//
//  Application.swift
//  DietTestApp
//
//  Created by Maksym Horbenko on 06.07.2021.
//

import UIKit
import IQKeyboardManagerSwift

let App = UIApplication.shared.delegate as! Application

@main
class Application: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    private let appCoordinator = MainCoordinator()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        setupKeyboardManager()
        setupDatabase()
        startApp()
        
        return true
    }
    
    private func setupKeyboardManager() {
        IQKeyboardManager.shared.enableAutoToolbar = false
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }
    
    private func setupDatabase() {
        Database.shared.setup()
        if DefaultsWrapper.firstAppLaunch {
            try? Database.shared.createStartingData()
            DefaultsWrapper.firstAppLaunch = false
        }
    }
    
    func startApp(animate: Bool? = true) {
        appCoordinator.start()
        setupRoot(
            vc: appCoordinator.navigationController,
            animate: animate
        )
    }
    
    private func setupRoot(
        vc: UIViewController,
        animate: Bool? = false
    ) {
        if window == nil {
            window = UIWindow(frame: UIScreen.main.bounds)
        }
        
        if animate == true {
            window?.setRootViewController(
                vc,
                options: UIWindow.TransitionOptions.init(
                    direction: .toRight,
                    style: .easeInOut
                )
            )
        } else {
            window?.rootViewController = vc
        }
        window?.makeKeyAndVisible()
    }
    
}

