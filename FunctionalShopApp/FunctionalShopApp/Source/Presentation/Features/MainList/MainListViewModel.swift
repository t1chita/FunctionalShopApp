//
//  MainListViewModel.swift
//  FunctionalShopApp
//
//  Created by Temur Chitashvili on 14.04.25.
//

import Foundation

enum ProductSortOption: String, CaseIterable, Identifiable {
    case nameAsc = "Name A-Z"
    case nameDesc = "Name Z-A"
    case priceLowHigh = "Price Low-High"
    case priceHighLow = "Price High-Low"
    
    var id: String { rawValue }
}

@Observable
final class MainListViewModel {
    var products: [Product] = []
    var isLoading: Bool = false
    var errorMessage: String?
    
    private let fetchProductsUseCase: FetchProductsUseCase
    
    var selectedSortOption: ProductSortOption = .nameAsc {
        didSet {
            applySort()
        }
    }
    
    private var allProducts: [Product] = []
    
    init(fetchProductsUseCase: FetchProductsUseCase) {
        self.fetchProductsUseCase = fetchProductsUseCase
    }
    
    func loadProducts() {
        Task {
            await MainActor.run { isLoading = true }
            
            do {
                let fetched = try await fetchProductsUseCase.execute()
                await MainActor.run {
                    self.allProducts = fetched
                    self.applySort()
                }
                self.errorMessage = nil
            } catch {
                errorMessage = error.localizedDescription
                print("Error: \(error)")
            }
            
            await MainActor.run { isLoading = false }
        }
    }
    
    
    private func applySort() {
        switch selectedSortOption {
        case .nameAsc:
            products = allProducts.sorted(by: \.name, ascending: true)
        case .nameDesc:
            products = allProducts.sorted(by: \.name, ascending: false)
        case .priceLowHigh:
            products = allProducts.sorted(by: \.computedPrice, ascending: true)
        case .priceHighLow:
            products = allProducts.sorted(by: \.computedPrice, ascending: false)
        }
    }
}

extension Array {
    func sorted<T: Comparable>(by keyPath: KeyPath<Element, T>, ascending: Bool = true) -> [Element] {
        sorted {
            let lhs = $0[keyPath: keyPath]
            let rhs = $1[keyPath: keyPath]
            return ascending ? (lhs < rhs) : (lhs > rhs)
        }
    }
}

extension Product {
    var computedPrice: Double {
        isOnSale ? price.saledPrice() : price
    }
}
