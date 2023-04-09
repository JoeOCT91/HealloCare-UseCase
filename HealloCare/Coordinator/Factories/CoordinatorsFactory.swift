//
//  CoordinatorsFactory.swift
//  heallocare
//
//  Created by Yousef Moahmed on 07/04/2023.
//


import UIKit
import RealmSwift

final class CoordinatorsFactory {
    
    func createApplicationCoordinator(router: AnyRouter) -> ApplicationCoordinator {
        let coordinatorFactory = CoordinatorsFactory()
        let repository = provideRepository()
        let modulesFactory = ModulesFactory(repository: repository)
        return ApplicationCoordinator(router: router, modulesFactory: modulesFactory, coordinatorsFactory: coordinatorFactory)
    }

    private func router(_ navController: UINavigationController? = nil) -> WeakRouter {
        return WeakRouter(rootController: navigationController(navController))
    }
    
    private func router(_ navController: UINavigationController? = nil) -> StrongRouter {
        return StrongRouter(rootController: navigationController(navController))
    }

    private func navigationController(_ navController: UINavigationController?) -> UINavigationController {
        if let navController = navController { return navController } else { return UINavigationController() }
    }
    
    private func provideRepository() -> GameRepository {
        let realm = try? Realm()
        let localDataSource = GameLocalDataSource.shared(realm)
        let remoteDataSource = NetworkManager.shared()
        return GameRepository.shared(remoteDataSource, localDataSource)
    }
}

extension CoordinatorsFactory: MainCoordinatorsFactory {
    
    func createGamesCoordinator(navigation: BaseUINavigationController?) -> GamesCoordinatorOutput {
        let router: StrongRouter = router(navigation)
        let repository = provideRepository()
        let factory = ModulesFactory(repository: repository)
        let coordinator = GamesCoordinator(router: router, factory: factory)
        return coordinator
      }

    func createFavoritesCoordinator(navigation: BaseUINavigationController?) -> FavoritesCoordinatorOutput {
        let router: StrongRouter = router(navigation)
        let repository = provideRepository()
        let factory = ModulesFactory(repository: repository)
        let coordinator = FavoritesCoordinator(router: router, factory: factory)
        return coordinator
    }
}
