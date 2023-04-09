//
//  GamesUseCase.swift
//  heallocare
//
//  Created by Yousef Moahmed on 08/04/2023.
//

import Foundation
import Combine

protocol GamesUseCase {
    func getGames(at page: Int) -> AnyPublisher<[GameModel], Error>
}
