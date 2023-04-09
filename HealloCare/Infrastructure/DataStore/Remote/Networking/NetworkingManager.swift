//
//  Networking.swift
//  heallocare
//
//  Created by Yousef Moahmed on 07/04/2023.
//

import Foundation
import Moya

protocol GameDataSourceProtocol: AnyObject {
    func getGames(page: Int) async -> Result<GamesResponse, Error>
    func getGameDetail(id: Int) async -> Result<GameDetailResponse, Error>
}

class NetworkManager {
    
    private static let networkLoggerPlugin: PluginType = NetworkLoggerPlugin(configuration: .init(logOptions: [.requestBody, .successResponseBody, .requestHeaders]))

    private var provider = MoyaProvider<APIRouter>(plugins: [networkLoggerPlugin])
    private static let sharedInstance = NetworkManager()
    
    // Private Init
    private init() {}
    
    class func shared() -> NetworkManager {
        return NetworkManager.sharedInstance
    }
    
    func getGames(page: Int) async -> Result<GamesResponse, Error> {
        await request(target: .games(page))
    }
    
    func getGameDetail(id: Int) async -> Result<GameDetailResponse, Error> {
        await request(target: .gameDetails(id))
    }
}

private extension NetworkManager {
    private  func request<T: Decodable>(target: APIRouter) async -> Result<T, Error> {
        await withCheckedContinuation { continuation in
            provider.request(target) { requestResult in
                switch requestResult {
                case .success(let response):
                    do {
                        continuation.resume(returning: try Result.success(response.map(T.self)))
                    } catch {
                        continuation.resume(returning: Result.failure(error))
                    }
                case .failure(let error):
                    continuation.resume(returning: Result.failure(error))
                }
            }
        }
    }
}
