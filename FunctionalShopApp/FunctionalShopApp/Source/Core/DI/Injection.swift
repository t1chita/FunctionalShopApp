//
//  Injection.swift
//  FunctionalShopApp
//
//  Created by Temur Chitashvili on 14.04.25.
//

import Foundation

struct Injection {
    private init() {}

    static let shared: Injection = Injection()

    // Injecting the ProductRepository
    func provideProductRepository() -> ProductRepository {
        return ProductRepositoryImpl(localDataSource: provideLocalDataSource())
    }

    // Injecting LocalDataSource
    func provideLocalDataSource() -> LocalProductDataSource {
        return LocalProductDataSourceImpl(networkService: provideNetworkService())
    }

    // Injecting FetchProductsUseCase
    func provideFetchProductsUseCase() -> FetchProductsUseCase {
        return FetchProductsUseCaseImpl(repository: provideProductRepository())
    }

    // Injecting MainListViewModel
    func provideMainListViewModel() -> MainListViewModel {
        return MainListViewModel(fetchProductsUseCase: provideFetchProductsUseCase())
    }
    
    // Injecting NetworkService
    func provideNetworkService() -> NetworkServiceProtocol {
        return NetworkService() // or return a mock if needed for testing
    }
}
