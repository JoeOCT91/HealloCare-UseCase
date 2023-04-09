//
//  GamesResponseGenre.swift
//  heallocare
//
//  Created by Yousef Moahmed on 08/04/2023.
//

import Foundation

public struct GamesResponseGenre: Codable {
    
    let id: Int
    let name, slug: String
    let domain, language: String?

    enum CodingKeys: String, CodingKey {
        case id, name, slug
        case domain, language
    }
}
