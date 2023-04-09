//
//  GamesResponseResult.swift
//  heallocare
//
//  Created by Yousef Moahmed on 08/04/2023.
//

import Foundation

struct GamesResponseResult: Codable {
    
    let id: Int
    let name: String
    let released: String
    let rating: Double
    let backgroundImage: String
    let metacritic: Int?
    let genres: [GamesResponseGenre]
    
    enum CodingKeys: String, CodingKey {
        case id, name, released
        case backgroundImage = "background_image"
        case rating, metacritic, genres
    }
}
