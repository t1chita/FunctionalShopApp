//
//  Product.swift
//  FunctionalShopApp
//
//  Created by Temur Chitashvili on 14.04.25.
//

import Foundation

struct Product: Identifiable, Decodable {
    let id: String
    let name: String
    let price: Double
    let category: String
    let rating: Double
    let isInStock: Bool
    let isOnSale: Bool
    let imageURL: String
}

extension Product {
    static let MOCK_PRODUCT = Product(
        id: "1",
        name: "Wireless Headphones",
        price: 99.99,
        category: "Electronics",
        rating: 4.5,
        isInStock: true,
        isOnSale: false,
        imageURL: "https://plus.unsplash.com/premium_photo-1677838847721-2bf14b48c256?w=500&auto=format&fit=crop"
    )
}
