//
//  MainCoordinatorsFactory.swift
//  heallocare
//
//  Created by Yousef Moahmed on 07/04/2023.
//

import Foundation

protocol MainCoordinatorsFactory {
    func createGamesCoordinator(navigation: BaseUINavigationController?) -> GamesCoordinatorOutput
    func createFavoritesCoordinator(navigation: BaseUINavigationController?) -> FavoritesCoordinatorOutput
}
