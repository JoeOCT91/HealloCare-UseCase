//
//  ApplicationCoordinator.swift
//  heallocare
//
//  Created by Yousef Moahmed on 07/04/2023.
//

import Foundation

class ApplicationCoordinator: Coordinator {
    
    private let router: AnyRouter
    private let modulesFactory: TabBarModuleFactory
    private let coordinatorsFactory: MainCoordinatorsFactory
    
    init(router: AnyRouter, modulesFactory: TabBarModuleFactory, coordinatorsFactory: MainCoordinatorsFactory) {
        self.router = router
        self.modulesFactory = modulesFactory
        self.coordinatorsFactory = coordinatorsFactory
    }
    
    override func start() {
        let tabBarOutput = modulesFactory.createTabBarOutput()
        tabBarOutput.onViewDidLoadNavigationControllers
            .receive(on: DispatchQueue.main)
            .sink { [weak self] navigationController in
                guard let self, let identifier = navigationController.navigationIdentifier else { return }
                switch identifier {
                case .games:
                    self.runGamesFlow(navigationController: navigationController)
                case .favorites:
                    self.runFavoritesFlow(navigationController: navigationController)
                }
            }.store(in: &subscriptions)
        router.setRootModule(tabBarOutput)
    }
    
    private func runGamesFlow(navigationController: BaseUINavigationController?) {
        let coordinator = coordinatorsFactory.createGamesCoordinator(navigation: navigationController)
        addDependency(coordinator)
        coordinator.start()
    
    }
    
    private func runFavoritesFlow(navigationController: BaseUINavigationController?) {
        let coordinator = coordinatorsFactory.createFavoritesCoordinator(navigation: navigationController)
        addDependency(coordinator)
        coordinator.start()
    }
}
