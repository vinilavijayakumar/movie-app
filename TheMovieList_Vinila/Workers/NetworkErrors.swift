//
//  NetworkErrors.swift
//  TheMovieList_Vinila
//
//  Created by Vinila Vijayakumar on 04/02/2026.
//

import Foundation

enum NetworkError: Error, LocalizedError {
    case badurlResponse(statusCode: Int)
    case missingConfig
    case invalidUrl
    case decodingFailed(underlyingError: Error)
    case dataLoadingFailed(underlyingError: Error)
    
    var errorDescription: String? {
        switch self {
        case .badurlResponse(let statusCode):
            return "Error \(statusCode) Failed to parse URL Response"
        case .missingConfig:
            return "Missing API Configuration"
        case .invalidUrl:
            return "Failed to build URL from the string"
        case .decodingFailed(let underlyingError):
            return "Failed to decode \(underlyingError.localizedDescription)"
        case .dataLoadingFailed(let underlyingError):
            return "Failed to load data \(underlyingError.localizedDescription)"
        }
    }
}
