//
//  ProductRepositoryImpl.swift
//  FunctionalShopApp
//
//  Created by Temur Chitashvili on 14.04.25.
//

import Foundation

final class ProductRepositoryImpl: ProductRepository {
    private let localDataSource: LocalProductDataSource
    
    init(localDataSource: LocalProductDataSource) {
        self.localDataSource = localDataSource
    }
    
    func fetchProducts() async throws -> [Product] {
        try await localDataSource.loadProducts()
    }
}
