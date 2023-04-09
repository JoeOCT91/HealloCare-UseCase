//
//  GameModel.swift
//  heallocare
//
//  Created by Yousef Moahmed on 07/04/2023.
//

import Foundation

struct GameModel: Codable, Hashable {
    
    let id: Int
    let name: String
    let backgroundImage: String
    let metacritic: Int
    let genres: [Genre]
    
    var joinedGenres: String {
        let genres = genres.map({$0.name})
        let joinedGenres = genres.joined(separator: ", ")
        return joinedGenres
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case backgroundImage = "background_image"
        case metacritic
        case genres
    }
}
