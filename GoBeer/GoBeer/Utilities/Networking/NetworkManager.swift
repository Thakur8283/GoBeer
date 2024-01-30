//
//  NetworkManager.swift
//  GoBeer
//
//  Created by Deepak Thakur on 30/01/24.
//

import Foundation
import UIKit

// MARK: - API Errors
enum APIError: Error {
    case badRequest
    case serverError
    case dataError
    case unknown
}

// MARK: - HTTP Response Status Codes
enum HttpStatusCode: Int {
    case success = 200
    case badRequest = 400
    case unauthorized = 401
    case internalServerError = 500
}


protocol NetworkRequestProtocol {
    func get(request: URLRequest) async throws -> Result<Data, Error>
}

final class NetworkManager: NetworkRequestProtocol {
    
    func get(request: URLRequest) async throws -> Result<Data, Error> {
        let (data, response) = try await URLSession.shared.data(for: request)
        return verifyResponse(data: data, response: response)
    }
    
    private func verifyResponse(data: Data, response: URLResponse) -> Result<Data, Error> {
        guard let httpResponse = response as? HTTPURLResponse else {
            return .failure(APIError.unknown)
        }
        
        switch httpResponse.statusCode {
        case 200...299:
            return .success(data)
        case 400...499:
            return .failure(APIError.badRequest)
        case 500...599:
            return .failure(APIError.serverError)
        default:
            return .failure(APIError.unknown)
        }
    }
}
