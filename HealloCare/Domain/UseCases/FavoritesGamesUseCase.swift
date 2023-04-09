//
//  FavoritesGamesUseCase.swift
//  heallocare
//
//  Created by Yousef Moahmed on 08/04/2023.
//

import Foundation
import Combine

protocol FavoritesGamesUseCase {
  func getGamesFav() -> AnyPublisher<[GameModel], Error>
}
