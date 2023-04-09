//
//  GameLocalDataSource.swift
//  heallocare
//
//  Created by Yousef Moahmed on 08/04/2023.
//

import Foundation
import Combine
import RealmSwift

protocol GameLocalDataSourceProtocol: AnyObject {
    func addGameToFav(game: GameEntity) -> AnyPublisher<Bool, Error>
    func getGamesFav() -> AnyPublisher<[GameEntity], Error>
    func isGameFav(game: GameEntity) -> AnyPublisher<Bool, Error>
    func removeGameFav(game: GameEntity) -> AnyPublisher<Bool, Error>
}

final class GameLocalDataSource: NSObject {
    
    private let realm: Realm?
    
    private init(realm: Realm?) {
        self.realm = realm
    }
    
    public static let shared: (Realm?) -> GameLocalDataSource = { realmDatabase in
        return GameLocalDataSource(realm: realmDatabase)
    }
}

extension GameLocalDataSource: GameLocalDataSourceProtocol {
    
    func addGameToFav(game: GameEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    try realm.write {
                        realm.add(game, update: .modified)
                    }
                    completion(.success(true))
                } catch {
                    completion(.failure(DataError.realmCreateError()))
                }
            } else {
                completion(.failure(DataError.realmError()))
            }
        }.eraseToAnyPublisher()
    }
    
    func getGamesFav() -> AnyPublisher<[GameEntity], Error> {
        return Future<[GameEntity], Error> { completion in
            if let realm = self.realm {
                let games: Results<GameEntity> = {
                    realm.objects(GameEntity.self)
                }()
                completion(.success(games.toArray(ofType: GameEntity.self)))
            } else {
                completion(.failure(DataError.realmError()))
            }
        }.eraseToAnyPublisher()
    }
    
    func isGameFav(game: GameEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                completion(.success(realm.object(ofType: GameEntity.self, forPrimaryKey: game.id) != nil))
            } else {
                completion(.failure(DataError.realmError()))
            }
        }.eraseToAnyPublisher()
    }
    
    func removeGameFav(game: GameEntity) -> AnyPublisher<Bool, Error> {
        return Future<Bool, Error> { completion in
            if let realm = self.realm {
                do {
                    let movie = realm.objects(GameEntity.self).filter("id == \(game.id)")
                    try realm.write {
                        realm.delete(movie)
                    }
                    completion(.success(true))
                } catch {
                    completion(.failure(DataError.realmDeleteError()))
                }
            } else {
                completion(.failure(DataError.realmError()))
            }
        }.eraseToAnyPublisher()
    }
}
