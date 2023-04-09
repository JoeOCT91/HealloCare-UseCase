//
//  GamesModuleFactory.swift
//  heallocare
//
//  Created by Yousef Moahmed on 07/04/2023.
//

import Foundation

class ModulesFactory {
    
}

extension ModulesFactory: TabBarModuleFactory {
    
    func createTabBarOutput() -> TabBarControllerOutput {
        var mainNavigationsControllers = [BaseUINavigationController]()
        TabBarNavigationIdentifier.allCases.forEach { navigationIdentifier in
            let navigation = BaseUINavigationController(navigationIdentifier: navigationIdentifier)
            mainNavigationsControllers.append(navigation)
        }
        let tabBarOutput = MainTabBarController(viewControllers: mainNavigationsControllers)
        return tabBarOutput
    }
}

extension ModulesFactory: GamesModulesFactory {
    
    func createGamesOutput() -> GamesControllerOutput {
        let viewModel = BaseViewModel()
        let controller = GamesController(viewModel: viewModel)
        return controller
    }
    
}

extension ModulesFactory: FavoritesModulesFactory {
    
    func createFavoritesOutput() -> FavoritesControllerOutput {
        let viewModel = BaseViewModel()
        let controller = FavoriteController(viewModel: viewModel)
        return controller
    }

}
