//
//  GenericWorker.swift
//  GenericFetcherExample
//
//  Created by Stuart on 27/10/2020.
//

import Foundation
import Combine

enum APIError: Error, LocalizedError {
    case unknown, apiError(reason: String)
    
    var errorDescription: String? {
        switch self {
        case .unknown:
            return "Unknown error"
        case .apiError(let reason):
            return reason
        }
    }
}

enum HTTPMethod: String {
    case get = "get"
    case post = "post"
    case put = "put"
}

protocol Fetcher {
    func fetch<T>(url: URL, httpMethod: HTTPMethod, using session: URLSession) -> AnyPublisher<T, APIError> where T: Decodable
}

// Define an extension so that we can provide a default value if we want
extension Fetcher {
    
    func fetch<T>(url: URL, httpMethod: HTTPMethod, using session: URLSession = URLSession.shared) -> AnyPublisher<T, APIError> where T: Decodable {
        fetch(url: url, httpMethod: httpMethod, using: session)
    }
}

struct GenericWorker: Fetcher {
    
    private let sessionProcessingQueue = DispatchQueue(label: "SessionProcessingQueue")
    
    func fetch<T>(url: URL, httpMethod: HTTPMethod, using session: URLSession) -> AnyPublisher<T, APIError> where T: Decodable {
        
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        
        return session.dataTaskPublisher(for: request)
            .retry(1)
            .receive(on: sessionProcessingQueue)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse else {
                    throw APIError.unknown
                }
                
                print(httpResponse.statusCode)
                
                guard 200..<300 ~= httpResponse.statusCode else {
                    throw APIError.unknown
                }
                
                let model =
                    try JSONDecoder().decode(T.self, from: data)
                
                return model
            }
            .mapError { error in
                if let error = error as? APIError {
                    return error
                } else {
                    return APIError.apiError(reason: error.localizedDescription)
                }
            }
            .eraseToAnyPublisher()
    }
    
}
