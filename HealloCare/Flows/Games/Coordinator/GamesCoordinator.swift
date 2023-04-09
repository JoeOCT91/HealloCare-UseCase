//
//  GamesCoordinator.swift
//  heallocare
//
//  Created by Yousef Moahmed on 07/04/2023.
//

import Foundation

protocol GamesCoordinatorOutput: AnyCoordinator {
    
}

final class GamesCoordinator: Coordinator, GamesCoordinatorOutput {
    
    private let router: AnyRouter
    private let factory: GamesModulesFactory
    
    init(router: AnyRouter, factory: GamesModulesFactory) {
        self.router = router
        self.factory = factory
    }
    
    override func start() {
        showGamesOutput()
    }
    
    private func showGamesOutput() {
        let gamesOutput = factory.createGamesOutput()
        gamesOutput.onGameDetailsTapPublisher
            .receive(on: DispatchQueue.main)
            .sink { [unowned self] game in
                showGameDetailsHandler(for: game)
            }.store(in: &subscriptions)
        router.setRootModule(gamesOutput)
    }
    
    private func showGameDetailsHandler(for game: GameModel) {
        let gameDetailsHandler = factory.createGameDetailsHandler(for: game)
        router.push(gameDetailsHandler, hideBottomBar: true)
    }
}
