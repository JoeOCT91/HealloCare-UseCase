//
//  AppDelegate.swift
//  heallocare
//
//  Created by Yousef Moahmed on 07/04/2023.
//

import UIKit
import SnapKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var rootController: UINavigationController {
        return self.window!.rootViewController as! UINavigationController
    }
    
    private lazy var applicationCoordinator: AnyCoordinator = self.createApplicationCoordinator()


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        createAndSetRootWindow()
        return true
    }
    
    private func createAndSetRootWindow() {
        let rootViewController = BaseUINavigationController()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        applicationCoordinator.start()
    }
    
    private func createApplicationCoordinator() -> ApplicationCoordinator {
        let router = WeakRouter(rootController: rootController)
        let coordinatorFactory = CoordinatorsFactory()
        let modulesFactory = ModulesFactory()
        return ApplicationCoordinator(router: router, modulesFactory: modulesFactory, coordinatorsFactory: coordinatorFactory)
    }

}

