//
//  APIRouter.swift
//  heallocare
//
//  Created by Yousef Moahmed on 07/04/2023.
//

import Foundation
import Moya

enum APIRouter: TargetType {
    
    case games(_ page: Int)
    case search(_ keyword: String, _ page: Int)
    case gameDetails(_ id: Int)
    
    var baseURL: URL {
        guard let baseURL = URL(string: URLs.baseURL) else {
            fatalError("Unable to create API base URL.")
        }
        return baseURL
    }
    
    var path: String {
        switch self {
        case .games:
            return URLs.games
        case .search:
            return URLs.games
        case.gameDetails(let gameId):
            return URLs.games.appendingPathComponent(gameId.string)
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Moya.Task {
        switch self {
        case .games(let page):
            let params: [String : Any] = [ParametersKeys.key: APIKey.key, ParametersKeys.page: page]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case.search(let keyword, let page):
            let params: [String : Any] = [ParametersKeys.key: APIKey.key, ParametersKeys.search: keyword, ParametersKeys.page: page]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .gameDetails:
            let params: [String : Any] = [ParametersKeys.key: APIKey.key]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }

}
