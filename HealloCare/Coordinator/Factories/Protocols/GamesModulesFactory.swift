//
//  GamesModulesFactory.swift
//  heallocare
//
//  Created by Yousef Moahmed on 07/04/2023.
//

import Foundation

protocol GamesModulesFactory {
    func createGamesOutput() -> GamesControllerOutput
    func createGameDetailsHandler(for game: GameModel) -> GameDetailsControllerOutput
}
