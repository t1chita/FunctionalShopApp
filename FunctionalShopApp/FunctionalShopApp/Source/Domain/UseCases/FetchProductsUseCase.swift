//
//  FetchProductsUseCase.swift
//  FunctionalShopApp
//
//  Created by Temur Chitashvili on 14.04.25.
//

import Foundation

protocol FetchProductsUseCase {
    func execute() async throws -> [Product]
}

final class FetchProductsUseCaseImpl: FetchProductsUseCase {
    private let repository: ProductRepository
    
    init(repository: ProductRepository) {
        self.repository = repository
    }
    
    func execute() async throws -> [Product] {
        try await repository.fetchProducts()
    }
}
