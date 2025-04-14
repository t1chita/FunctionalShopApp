//
//  MainListView.swift
//  FunctionalShopApp
//
//  Created by Temur Chitashvili on 12.04.25.
//

import SwiftUI


struct MainListView: View {
    @Bindable var vm: MainListViewModel

    
    var body: some View {
        ZStack {
            Color
                .background
                .ignoresSafeArea()
            
            ScrollView {
                LazyVStack(spacing: 8) {
                    ForEach(vm.products) { product in
                        ProductCard(product: product)
                    }
                }
                .padding(.horizontal)
            }
        }
        .task {
            vm.loadProducts()
        }
    }
}

#Preview {
    MyTabView()
}
