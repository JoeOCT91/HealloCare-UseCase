//
//  GameDetailResponse.swift
//  heallocare
//
//  Created by Yousef Moahmed on 08/04/2023.
//

import Foundation

// MARK: - GameDetailResponse
public struct GameDetailResponse: Codable {
    
    let id: Int
    let name, description: String
    let metacritic: Int?
    let released: String
    let backgroundImage: String
    let rating: Double
    let genres: [GamesResponseGenre]

    enum CodingKeys: String, CodingKey {
        case id, name, description, metacritic, released
        case backgroundImage = "background_image"
        case rating
        case genres
    }
}

// MARK: - GameDetailResponseAddedByStatus
public struct GameDetailResponseAddedByStatus: Codable {
    let yet, owned, beaten, toplay: Int
    let dropped, playing: Int
}

// MARK: - GameDetailResponseEsrbRating
public struct GameDetailResponseEsrbRating: Codable {
    let id: Int
    let name, slug: String
}

// MARK: - GameDetailResponseMetacriticPlatform
public struct GameDetailResponseMetacriticPlatform: Codable {
    let metascore: Int
    let url: String
    let platform: GameDetailResponseMetacriticPlatformPlatform
}

// MARK: - GameDetailResponseMetacriticPlatformPlatform
public struct GameDetailResponseMetacriticPlatformPlatform: Codable {
    let platform: Int
    let name, slug: String
}

// MARK: - GameDetailResponseParentPlatform
public struct GameDetailResponseParentPlatform: Codable {
    let platform: GameDetailResponseEsrbRating
}

// MARK: - GameDetailResponsePlatformElement
public struct GameDetailResponsePlatformElement: Codable {
    let platform: GameDetailResponsePlatformPlatform
    let releasedAt: String?
    let requirements: GameDetailResponseRequirements

    enum CodingKeys: String, CodingKey {
        case platform
        case releasedAt = "released_at"
        case requirements
    }
}

// MARK: - GameDetailResponsePlatformPlatform
public struct GameDetailResponsePlatformPlatform: Codable {
    let id: Int
    let name, slug, image, yearEnd: String?
    let yearStart, gamesCount: Int?
    let imageBackground: String

    enum CodingKeys: String, CodingKey {
        case id, name, slug, image
        case yearEnd = "year_end"
        case yearStart = "year_start"
        case gamesCount = "games_count"
        case imageBackground = "image_background"
    }
}

// MARK: - GameDetailResponseRequirements
public struct GameDetailResponseRequirements: Codable {
}

// MARK: - GameDetailResponseRating
public struct GameDetailResponseRating: Codable {
    let id: Int
    let title: String
    let count: Int
    let percent: Double
}

// MARK: - GameDetailResponseReactions
public struct GameDetailResponseReactions: Codable {
    let the1: Int

    enum CodingKeys: String, CodingKey {
        case the1 = "1"
    }
}
