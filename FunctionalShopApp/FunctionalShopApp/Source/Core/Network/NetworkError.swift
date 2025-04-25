//
//  NetworkError.swift
//  FunctionalShopApp
//
//  Created by Temur Chitashvili on 15.04.25.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingFailed
    case serverError(String)
    case unknown
}
