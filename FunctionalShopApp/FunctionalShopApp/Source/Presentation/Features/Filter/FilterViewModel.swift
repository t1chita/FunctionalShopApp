//
//  FilterViewModel.swift
//  FunctionalShopApp
//
//  Created by Temur Chitashvili on 25.04.25.
//

import Foundation

@Observable
final class FilterViewModel {
    let categories: [String] = [
        "Electronics",
        "Computers",
        "Accessories",
        "Storage",
        "Wearables",
        "Audio",
        "Photography",
        "Furniture"
    ]
    var selectedCategory: String = ""
    var selectedRating: Int = 0
    var selectedPrice: CGFloat = 0
    var offset: CGFloat = 0
    var showInStockOnly: Bool = false
    var showOnlyOnSale: Bool = false
    
    var isClearDisabled: Bool {
        selectedCategory.isEmpty &&
        selectedRating == 0 &&
        selectedPrice == 0 &&
        showOnlyOnSale == false &&
        showInStockOnly == false
    }
    
    func clearFilters() {
        selectedCategory = ""
        selectedRating = 0
        selectedPrice = 0
        offset = 0
        showOnlyOnSale = false
        showInStockOnly = false
    }
}
