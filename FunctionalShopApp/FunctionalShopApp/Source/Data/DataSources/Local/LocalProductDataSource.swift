//
//  LocalProductDataSource.swift
//  FunctionalShopApp
//
//  Created by Temur Chitashvili on 14.04.25.
//

import Foundation

protocol LocalProductDataSource {
    func loadProducts() async throws -> [Product]
}

final class LocalProductDataSourceImpl: LocalProductDataSource {
    private let networkService: NetworkServiceProtocol

    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }

    func loadProducts() async throws -> [Product] {
        return try await networkService.request(EndPointsManager.getProducts, responseType: [Product].self)
    }
}
