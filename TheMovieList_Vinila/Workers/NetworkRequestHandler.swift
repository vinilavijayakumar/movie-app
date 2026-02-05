//
//  NetworkRequestHandler.swift
//  TheMovieList_Vinila
//
//  Created by Vinila Vijayakumar on 04/02/2026.
//
import Foundation

class NetworkRequestHandler{
    
    private var session : URLSession
    
    init(){
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["Content-Type":"application/json"]
        session = URLSession(configuration: configuration)
    }
    
    func fetchData<T: Codable>(
        urlstring: String,
        responseType: T.Type
    ) async throws -> T{
        guard let url = URL(string: urlstring) else{
            throw NetworkError.invalidUrl
        }
        
        let (data,response) = try await session.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, (200...299).contains( httpResponse.statusCode) else{
            throw NetworkError.badurlResponse(statusCode: (response as? HTTPURLResponse)?.statusCode ?? 0)
        }
        
        do{
            return try JSONDecoder().decode(T.self, from: data)
        }catch{
            throw NetworkError.decodingFailed(underlyingError: error)
        }
    }
  
}
