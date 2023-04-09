//
//  FavoritesGamesViewModel.swift
//  heallocare
//
//  Created by Yousef Moahmed on 08/04/2023.
//

import Foundation

protocol FavoritesGamesViewModelProtocol: AnyViewModel {
    
}

class FavoritesGamesViewModel: BaseViewModel, FavoritesGamesViewModelProtocol {
    
    private let favoritesGamesUseCase: FavoritesGamesViewModel
    
    init(favoritesGamesUseCase: FavoritesGamesViewModel) {
        self.favoritesGamesUseCase = favoritesGamesUseCase
        super.init()
    }
    
}
