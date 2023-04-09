//
//  GameResponse.swift
//  heallocare
//
//  Created by Yousef Moahmed on 07/04/2023.
//

import Foundation

struct GamesResponse: Codable {
    let count: Int
    let results: [GamesResponseResult]
    let error: String?
}
