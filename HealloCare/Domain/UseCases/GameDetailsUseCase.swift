//
//  GameDetailsUseCase.swift
//  heallocare
//
//  Created by Yousef Moahmed on 08/04/2023.
//

import Foundation
import Combine

protocol GameDetailUseCase {
  func getGameDetail(id: Int) -> AnyPublisher<GameModel, Error>
  func addGameToFav(game: GameModel) -> AnyPublisher<Bool, Error>
  func isGameFav(game: GameModel) -> AnyPublisher<Bool, Error>
  func removeGameFav(game: GameModel) -> AnyPublisher<Bool, Error>
}
