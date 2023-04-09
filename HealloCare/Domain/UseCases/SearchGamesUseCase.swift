//
//  SearchGamesUseCase.swift
//  heallocare
//
//  Created by Yousef Moahmed on 09/04/2023.
//

import Foundation
import Combine

protocol SearchGamesUseCase {
    func searchGames(for game: String, at page: Int) -> AnyPublisher<[GameModel], Error>
}
