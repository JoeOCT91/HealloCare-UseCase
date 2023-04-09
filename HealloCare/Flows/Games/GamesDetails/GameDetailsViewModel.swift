//
//  GameDetailsViewModel.swift
//  heallocare
//
//  Created by Yousef Moahmed on 08/04/2023.
//

import Foundation
import Combine

protocol GameDetailsViewModelProtocol: AnyViewModel {
    var gameDetailsPublisher: Published<GameModel>.Publisher { get }
    var isFavoritePublisher: AnyPublisher<Bool, Never> { get }
    
    func changeGameFavoriteState()
}

class GameDetailsViewModel: BaseViewModel, GameDetailsViewModelProtocol {
    
    private let gameDetailsUseCase: GameDetailUseCase
    @Published private var game: GameModel
    
    var gameDetailsPublisher: Published<GameModel>.Publisher { $game }
    var isFavoritePublisher: AnyPublisher<Bool, Never> {
        $game
            .flatMap { CurrentValueSubject<Bool, Never>($0.isFav) }
            .removeDuplicates()
            .eraseToAnyPublisher()
    }
    
    init(gameDetailsUseCase: GameDetailUseCase, game: GameModel) {
        self.gameDetailsUseCase = gameDetailsUseCase
        self.game = game
        super.init()
        fetchGame()
    }
    
    private func fetchGame() {
        gameDetailsUseCase.getGameDetail(id: game.id)
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] game in
                guard let self else { return }
                self.game = game
                DispatchQueue.main.async {
                    self.isGameFav()
                }
            }.store(in: &subscriptions)
    }
    
    func changeGameFavoriteState() {
        if game.isFav {
            removeGameFromFavorites()
        } else {
            addGameToFavorites()
        }
    }
    
    private func addGameToFavorites() {
        gameDetailsUseCase.addGameToFav(game: game)
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] isAdded in
                guard let self else { return }
                self.game.isFav = isAdded
            }.store(in: &subscriptions)
    }
    
    private func removeGameFromFavorites() {
        gameDetailsUseCase.removeGameFav(game: game)
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] isRemoved in
                guard let self else { return }
                self.game.isFav = !isRemoved
            }.store(in: &subscriptions)
    }
    
    private func isGameFav() {
        gameDetailsUseCase.isGameFav(game: self.game)
            .subscribe(on: RunLoop.main)
            .sink(receiveCompletion: { completion in
                debugPrint("Task finished with \(completion)")
            },receiveValue: { state in
                print(state)
                self.game.isFav = state
            }).store(in: &subscriptions)
    }
}
