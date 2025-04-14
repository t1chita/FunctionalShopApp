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
    func loadProducts() async throws -> [Product] {
        let products: [Product] = JSONLoader.load("products", as: [Product].self)
        return products
    }
}
