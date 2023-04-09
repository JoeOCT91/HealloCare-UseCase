//
//  FavoritesCoordinator.swift
//  heallocare
//
//  Created by Yousef Moahmed on 07/04/2023.
//

import Foundation

protocol FavoritesCoordinatorOutput: AnyCoordinator {
    
}

final class FavoritesCoordinator: Coordinator, FavoritesCoordinatorOutput {
    
    let router: AnyRouter
    let factory: FavoritesModulesFactory
    
    init(router: AnyRouter, factory: FavoritesModulesFactory) {
        self.router = router
        self.factory = factory
    }
    
    override func start() {
        showFavorites()
    }
    
    private func showFavorites() {
        let favoritesOutput = factory.createFavoritesOutput()
        router.setRootModule(favoritesOutput)
    }
    
}
