//
//  CoordinatorsFactory.swift
//  heallocare
//
//  Created by Yousef Moahmed on 07/04/2023.
//


import UIKit

final class CoordinatorsFactory {

    private func router(_ navController: UINavigationController? = nil) -> WeakRouter {
        return WeakRouter(rootController: navigationController(navController))
    }
    
    private func router(_ navController: UINavigationController? = nil) -> StrongRouter {
        return StrongRouter(rootController: navigationController(navController))
    }

    private func navigationController(_ navController: UINavigationController?) -> UINavigationController {
        if let navController = navController { return navController } else { return UINavigationController() }
    }
}

extension CoordinatorsFactory: MainCoordinatorsFactory {
    
    func createGamesCoordinator(navigation: BaseUINavigationController?) -> GamesCoordinatorOutput {
        let router: StrongRouter = router(navigation)
        let factory = ModulesFactory()
        let coordinator = GamesCoordinator(router: router, factory: factory)
        return coordinator
      }

    func createFavoritesCoordinator(navigation: BaseUINavigationController?) -> FavoritesCoordinatorOutput {
        let router: StrongRouter = router(navigation)
        let factory = ModulesFactory()
        let coordinator = FavoritesCoordinator(router: router, factory: factory)
        return coordinator
    }
}
