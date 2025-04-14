//
//  ImageRetriever.swift
//  FunctionalShopApp
//
//  Created by Temur Chitashvili on 14.04.25.
//


import Foundation

struct ImageRetriever {
    func fetch(_ imageUrl: String) async throws -> Data {
        guard let url = URL(string: imageUrl) else {
            throw ImageRetriever.RetrieverError.invalidUrl
        }
        
        let (data, _ ) = try await URLSession.shared.data(from: url)
        
        return data
    }
}

private extension ImageRetriever {
    enum RetrieverError: Error {
        case invalidUrl
    }
}
