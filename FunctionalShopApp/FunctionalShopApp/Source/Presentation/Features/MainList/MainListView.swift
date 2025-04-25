//
//  MainListView.swift
//  FunctionalShopApp
//
//  Created by Temur Chitashvili on 12.04.25.
//

import SwiftUI
import Lottie

struct MainListView: View {
    @Bindable var vm: MainListViewModel
    @State private var isShowingSortOptions = false
    
    var body: some View {
        content()
            .task {
                vm.loadProducts()
            }
    }
    
    private func content() -> some View {
        ZStack {
            Color
                .background
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                pageTitleAndSortingButton()
                
                productsList()
            }
            .padding(.horizontal)
        }
    }
    
    private func pageTitleAndSortingButton() -> some View {
        HStack(spacing: 4) {
            FShopText(text: "Products", style: .title)
            
            Spacer()
            
            Button {
                isShowingSortOptions = true
            } label: {
                HStack(spacing: 4) {
                    FShopText(text: "Sort By", style: .body)
                    Image(systemName: "list.bullet")
                }
            }
        }
        .confirmationDialog("Sort Products", isPresented: $isShowingSortOptions, titleVisibility: .visible) {
            ForEach(ProductSortOption.allCases) { option in
                Button(option.rawValue) {
                    vm.selectedSortOption = option
                }
            }
        }
    }
    
    private func productsList() -> some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                ForEach(vm.products) { product in
                    ProductCard(product: product)
                }
            }
        }
        .scrollIndicators(.hidden)
    }
    
}

#Preview {
    MyTabView()
}
