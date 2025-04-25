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
}
