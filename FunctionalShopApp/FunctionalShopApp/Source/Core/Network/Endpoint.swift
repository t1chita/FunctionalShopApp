//
//  Endpoint.swift
//  FunctionalShopApp
//
//  Created by Temur Chitashvili on 15.04.25.
//

import Foundation

// MARK: - HTTP Method Enum
enum HTTPMethod: String {
    case GET, POST, PUT, DELETE
}

// MARK: - Endpoint Protocol
protocol Endpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var queryItems: [URLQueryItem]? { get }
    var body: Data? { get }
}

extension Endpoint {
    var urlRequest: URLRequest? {
        var components = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false)
        components?.queryItems = queryItems

        guard let url = components?.url else { return nil }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.allHTTPHeaderFields = headers
        request.httpBody = body
        
        return request
    }
}

// MARK: - Your Endpoint Enum
enum EndPointsManager: Endpoint {
    case getProducts
}

extension EndPointsManager {
    var baseURL: URL {
        return URL(string: "https://mocki.io")!
    }
    
    var path: String {
        switch self {
        case .getProducts:
            return "/v1/55113d6a-910e-464d-819b-b71378988747"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getProducts:
            return .GET
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    var queryItems: [URLQueryItem]? {
        return nil
    }
    
    var body: Data? {
        return nil
    }
}
