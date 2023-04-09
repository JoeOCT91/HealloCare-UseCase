//
//  GameRepository.swift
//  heallocare
//
//  Created by Yousef Moahmed on 08/04/2023.
//

import Foundation
import Combine

class GameRepository: NSObject {
    
    typealias GameInstance = (GameDataSourceProtocol, GameLocalDataSource) -> GameRepository
    
    fileprivate let remote: GameDataSourceProtocol
    fileprivate let local: GameLocalDataSource
    
    private init(remote: GameDataSourceProtocol, local: GameLocalDataSource) {
        self.remote = remote
        self.local = local
    }
    
    public static let shared: GameInstance = { (remote, local) in
        return GameRepository(remote: remote, local: local)
    }
}

extension GameRepository: GamesUseCase {

    func getGames(at page: Int) -> AnyPublisher<[GameModel], Error> {
        return Future { promise in
            Task {
                let result = await self.remote.getGames(page: page)
                switch result {
                case .success(let success):
                    let gamesModels = GameMapper.mapGameResponsesToDomains(input: success)
                    promise(.success(gamesModels))
                case .failure(let failure):
                    promise(.failure(failure))
                }
            }
        }.eraseToAnyPublisher()
    }
}

extension GameRepository: SearchGamesUseCase {
    
    func searchGames(for game: String, at page: Int) -> AnyPublisher<[GameModel], Error> {
        return Future { promise in
            Task {
                let result = await self.remote.searchGames(keyword: game, page: page)
                switch result {
                case .success(let success):
                    let gamesModels = GameMapper.mapGameResponsesToDomains(input: success)
                    promise(.success(gamesModels))
                case .failure(let failure):
                    promise(.failure(failure))
                }
            }
        }.eraseToAnyPublisher()
    }

}

extension GameRepository: GameDetailUseCase {

    func getGameDetail(id: Int) -> AnyPublisher<GameModel, Error> {
        return Future { promise in
            Task {
                let result = await self.remote.getGameDetail(id: id)
                switch result {
                case .success(let success):
                    let gamesModels = GameMapper.mapGameDetailResponseToDomain(input: success)
                    promise(.success(gamesModels))
                case .failure(let failure):
                    promise(.failure(failure))
                }
            }
        }.eraseToAnyPublisher()
    }
    
    func addGameToFav(game: GameModel) -> AnyPublisher<Bool, Error> {
        return self.local.addGameToFav(game: GameMapper.mapGameToEntity(input: game))
    }
    
    func isGameFav(game: GameModel) -> AnyPublisher<Bool, Error> {
        return self.local.isGameFav(game: GameMapper.mapGameToEntity(input: game))
    }
    
    func removeGameFav(game: GameModel) -> AnyPublisher<Bool, Error> {
        return self.local.removeGameFav(game: GameMapper.mapGameToEntity(input: game))
    }
}

extension GameRepository: FavoritesGamesUseCase {
    
    func getGamesFav() -> AnyPublisher<[GameModel], Error> {
        return self.local.getGamesFav()
            .map {GameMapper.mapGameEntitiesToDomains(input: $0)}
            .eraseToAnyPublisher()
    }
    
}
