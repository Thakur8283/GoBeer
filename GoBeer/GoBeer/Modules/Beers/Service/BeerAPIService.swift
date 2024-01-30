//
//  BeerAPIService.swift
//  GoBeer
//
//  Created by Deepak Thakur on 30/01/24.
//

import Foundation

protocol BeerAPIProtocol {
    func getAllBeers() async throws -> [BeerResponseProtocol]
}

enum BeerAPIError: Error {
    case invalidURL
    case invalidResponseFormat
}

final class BeerAPIService: BeerAPIProtocol {
    private let networkManager: NetworkRequestProtocol
    
    init(networkManager: NetworkRequestProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func getAllBeers() async throws -> [BeerResponseProtocol] {
        guard let apiURL = URL(string: APIConstants.apiURL) else {
            throw BeerAPIError.invalidURL
        }
        let urlRequest = URLRequest(url: apiURL)
        let apiData = try await networkManager.get(request: urlRequest)
        switch apiData {
        case .success(let data):
            let decoder = JSONDecoder()
            do {
                return try decoder.decode([BeerAPIResponse].self, from: data)
            } catch {
                throw BeerAPIError.invalidResponseFormat
            }
        case .failure(let error):
            throw error
        }
    }
}
