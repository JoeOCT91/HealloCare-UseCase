//
//  FavoritesGamesViewModel.swift
//  heallocare
//
//  Created by Yousef Moahmed on 08/04/2023.
//

import Foundation
import Combine

protocol FavoritesGamesViewModelProtocol: AnyViewModel {
    var gamesListPublisher: Published<[GameModel]>.Publisher { get }
    var isFavoritesEmpty: AnyPublisher<Bool, Never> { get }
    func refreshFavorites()
}

class FavoritesGamesViewModel: BaseViewModel, FavoritesGamesViewModelProtocol {
    
    private let favoritesGamesUseCase: FavoritesGamesUseCase
    @Published private var gamesList = [GameModel]()
    var gamesListPublisher: Published<[GameModel]>.Publisher { $gamesList }
    
    var isFavoritesEmpty: AnyPublisher<Bool, Never> {
        $gamesList
            .flatMap{ CurrentValueSubject<Bool, Never>($0.isEmpty) }
            .eraseToAnyPublisher()
    }
    
    init(favoritesGamesUseCase: FavoritesGamesUseCase) {
        self.favoritesGamesUseCase = favoritesGamesUseCase
        super.init()
        fetchFavGames()
    }
    
    public func fetchFavGames() {
        favoritesGamesUseCase.getGamesFav()
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] gamesList in
                guard let self else { return }
                self.gamesList = gamesList
            }.store(in: &subscriptions)
    }
    
    func refreshFavorites() {
        fetchFavGames()
    }
}
