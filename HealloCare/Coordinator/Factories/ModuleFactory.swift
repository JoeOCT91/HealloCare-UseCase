//
//  GamesModuleFactory.swift
//  heallocare
//
//  Created by Yousef Moahmed on 07/04/2023.
//

import UIKit

class ModulesFactory: NSObject {
    
    let repository: GameRepository
    
    init(repository: GameRepository) {
        self.repository = repository
    }
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
        let searchHandler = createSearchResultHandler()
        let viewModel = GamesViewModel(gamesUseCase: repository)
        let controller = GamesController(viewModel: viewModel, searchResultHandler: searchHandler)
        return controller
    }
    
    func createGameDetailsHandler(for game: GameModel) -> GameDetailsControllerOutput {
        let viewModel = GameDetailsViewModel(gameDetailsUseCase: repository, game: game)
        let controller = GameDetailsController(viewModel: viewModel)
        return controller
    }
    
    private func createSearchResultHandler() -> SearchResultController {
        let viewModel = SearchResultViewModel(searchGamesUseCase: repository)
        let controller = SearchResultController(viewModel: viewModel)
        return controller
    }
}

extension ModulesFactory: FavoritesModulesFactory {
    
    func createFavoritesOutput() -> FavoritesControllerOutput {
        let viewModel = FavoritesGamesViewModel(favoritesGamesUseCase: repository)
        let controller = FavoritesController(viewModel: viewModel)
        return controller
    }
}
