//
//  GameModel.swift
//  heallocare
//
//  Created by Yousef Moahmed on 07/04/2023.
//

import Foundation

struct GameModel: Hashable, Equatable, Identifiable {
    
    var id: Int
    var name: String
    var rating: Float
    var image: String
    var desc: String
    var releaseDate: String
    let metacritic: Int
    let genres: String
    var isFav: Bool

}
