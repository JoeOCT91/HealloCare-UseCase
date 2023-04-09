//
//  GamesViewModel.swift
//  heallocare
//
//  Created by Yousef Moahmed on 07/04/2023.
//

import Foundation

protocol GamesViewModelProtocol: AnyViewModel {
    var gamesListPublisher: Published<[GameModel]>.Publisher { get }
    func fetchDataIfNeeded(for indexPath: IndexPath)
}

class GamesViewModel: BaseViewModel, GamesViewModelProtocol {
    
    private let gamesUseCase: GamesUseCase
    private var currentPage: Int = 0
    private var hasMoreDate: Bool = true
    @Published private var gamesList = [GameModel]()

    var gamesListPublisher: Published<[GameModel]>.Publisher { $gamesList }
    
    
    init(gamesUseCase: GamesUseCase) {
        self.gamesUseCase = gamesUseCase
        super.init()
        currentPage += 1
        fetchGames(at: currentPage)
    }
    
    func fetchGames(at page: Int) {
        gamesUseCase.getGames(at: page)
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] gamesList in
                guard let self else { return }
                self.gamesList.append(contentsOf: gamesList)
            }.store(in: &subscriptions)
    }
    
    func fetchDataIfNeeded(for indexPath: IndexPath) {
        guard indexPath.row == gamesList.count - 1, hasMoreDate else { return }
        currentPage += 1
        fetchGames(at: currentPage)
    }

}
