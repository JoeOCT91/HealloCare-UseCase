//
//  GameMapper.swift
//  heallocare
//
//  Created by Yousef Moahmed on 08/04/2023.
//

import Foundation
final class GameMapper {
    static func mapGameResponsesToDomains(input gameResponse: GamesResponse) -> [GameModel] {
        return gameResponse.results.map { result in
            
            var joinedGenres: String {
                return result.genres
                    .map({$0.name})
                    .joined(separator: ", ")
            }
            
            return GameModel(id: result.id,
                             name: result.name,
                             rating: Float(result.rating),
                             image: result.backgroundImage,
                             desc: "",
                             releaseDate: result.released,
                             metacritic: result.metacritic ?? 0,
                             genres: joinedGenres,
                             isFav: false)
        }
    }
    
    static func mapGameDetailResponseToDomain(input result: GameDetailResponse) -> GameModel {
        var joinedGenres: String {
            return result.genres
                .map({$0.name})
                .joined(separator: ", ")
        }
        return GameModel(id: result.id,
                         name: result.name,
                         rating: Float(result.rating),
                         image: result.backgroundImage,
                         desc: result.description,
                         releaseDate: result.released,
                         metacritic: result.metacritic ?? 0,
                         genres: joinedGenres,
                         isFav: false)
    }

    public static func mapGameToEntity(input game: GameModel) -> GameEntity {
        let result = game
        let newGame = GameEntity()
        newGame.id = result.id
        newGame.title = result.name
        newGame.rating = result.rating
        newGame.image = result.image
        newGame.releaseDate = result.releaseDate
        return newGame
    }

    static func mapGameEntitiesToDomains(input gameEntities: [GameEntity]) -> [GameModel] {
        return gameEntities.map { result in
            GameModel(id: result.id,
                      name: result.title,
                      rating: result.rating,
                      image: result.image,
                      desc: result.desc,
                      releaseDate: result.releaseDate,
                      metacritic: result.metacritic,
                      genres: "",
                      isFav: false)
        }
    }
}
