//
//  ProductRepository.swift
//  FunctionalShopApp
//
//  Created by Temur Chitashvili on 14.04.25.
//

import Foundation

protocol ProductRepository {
    func fetchProducts() async throws -> [Product]
}
