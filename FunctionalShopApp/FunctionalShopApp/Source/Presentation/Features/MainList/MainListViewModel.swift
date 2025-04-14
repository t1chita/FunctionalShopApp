//
//  MainListViewModel.swift
//  FunctionalShopApp
//
//  Created by Temur Chitashvili on 14.04.25.
//

import Foundation

@Observable
final class MainListViewModel {
    var products: [Product] = []
    var isLoading: Bool = false
    var errorMessage: String?
    
    private let fetchProductsUseCase: FetchProductsUseCase
    
    init(fetchProductsUseCase: FetchProductsUseCase) {
        self.fetchProductsUseCase = fetchProductsUseCase
    }
    
    func loadProducts() {
        Task {
            await MainActor.run {
                isLoading = true
            }
            
            do {
                let products = try await fetchProductsUseCase.execute()
                await MainActor.run {
                    self.products = products
                }
                self.errorMessage = nil
            } catch {
                errorMessage = error.localizedDescription
                print("Error: \(error)")
            }
            
            await MainActor.run {
                isLoading = false
            }
        }
    }
}
