//
//  FilterView.swift
//  FunctionalShopApp
//
//  Created by Temur Chitashvili on 12.04.25.
//

import SwiftUI

struct FilterView: View {
    private let maxValue: CGFloat = 1000 // Maximum value in GEL
    @Bindable var vm: FilterViewModel
    @EnvironmentObject var currencyManager: CurrencyManager
    var body: some View {
        content()
    }
    
    private func content() -> some View {
        ZStack {
            Color
                .background
                .ignoresSafeArea()
            
            VStack(spacing: 24) {
                pageTitle()
                    .padding(.horizontal)
                
                categorySegmentedControl()
                
                slider()
                    .padding(.horizontal)
                
                ratingFilter()
                    .padding(.horizontal)
                
                toggleFilters()
                    .padding(.horizontal)
                
                clearOrApplyFilters()
                    .padding(.horizontal)
                
                Spacer()
            }
        }
    }
    
    private func pageTitle() -> some View {
        HStack(spacing: 4) {
            FShopText(text: "Filter", style: .title)
            
            Spacer()
        }
    }
    
    private func categorySegmentedControl() -> some View {
        ScrollViewReader { proxy in
            ScrollView(.horizontal) {
                HStack(spacing: 8) {
                    Button {
                        withAnimation {
                            vm.selectedCategory = "" // Deselects category, shows all categories
                        }
                    } label: {
                        Text("Any Category")
                            .foregroundStyle(vm.selectedCategory.isEmpty ? .white : .primaryText)
                            .font(.system(size: 14, weight: .semibold))
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(
                                Capsule()
                                    .foregroundStyle(vm.selectedCategory.isEmpty ? .accent : .clear)
                                    .overlay {
                                        Capsule()
                                            .stroke(lineWidth: 1)
                                            .foregroundStyle(!vm.selectedCategory.isEmpty ? .accent : .clear)
                                    }
                            )
                    }
                    .padding(.leading, 16)
                    .id("Any Category")

                    LazyHStack {
                        ForEach(vm.categories, id: \.self) { category in
                            categoryButton(category)
                                .id(category)
                        }
                    }
                }
            }
            .frame(height: 26)
            .scrollIndicators(.hidden)
            .onChange(of: vm.selectedCategory) { oldValue, newValue in
                withAnimation(.easeInOut) {
                    if !vm.selectedCategory.isEmpty {
                        proxy.scrollTo(vm.selectedCategory, anchor: .center)
                    } else {
                        proxy.scrollTo("Any Category", anchor: .center)
                    }
                }
            }
        }
    }
    
    private func categoryButton(_ category: String) -> some View {
        Button {
            withAnimation {
                vm.selectedCategory = category
            }
        } label: {
            Text(category)
                .foregroundStyle( vm.selectedCategory == category ? .white : .primaryText)
                .font(.system(size: 14, weight: .semibold))
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(
                    Capsule()
                        .foregroundStyle(vm.selectedCategory == category ? .accent : .clear)
                        .overlay {
                            Capsule()
                                .stroke(lineWidth: 1)
                                .foregroundStyle(vm.selectedCategory != category ? .accent : .clear)
                            
                        }
                )
        }
    }
    
    private func slider() -> some View {
        VStack(spacing: 8) {
            HStack {
                Text("Maximum price")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundStyle(.primaryText)
                
                Spacer()
                
                Text(currencyManager.format(price: vm.selectedPrice))
                    .font(.system(size: 20, weight: .regular))
                    .foregroundStyle(.primaryText)
            }
            
            GeometryReader { geometry in
                let totalWidth = geometry.size.width - 16 // padding for handle
                ZStack(alignment: .leading) {
                    Capsule()
                        .foregroundStyle(.teritaryText)
                        .frame(height: 16)
                    
                    Capsule()
                        .foregroundStyle(.primaryButton)
                        .frame(width: max(0, vm.offset + 20), height: 16)
                    
                    Circle()
                        .fill(.primaryButton)
                        .frame(width: 24, height: 24)
                        .overlay {
                            Circle()
                                .stroke(lineWidth: 2)
                                .foregroundStyle(.accent)
                        }
                        .offset(x: max(0, min(vm.offset, totalWidth)))
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    let newOffset = value.location.x - 8
                                    vm.offset = max(0, min(newOffset, totalWidth))
                                    vm.selectedPrice = (vm.offset / totalWidth) * maxValue
                                }
                        )
                }
            }
            .frame(height: 20)
        }
    }
    
    private func ratingFilter() -> some View {
        HStack(spacing: 8) {
            Text("Minimum rating")
                .font(.system(size: 16, weight: .medium))
                .foregroundStyle(.primaryText)
            
            Spacer()
            
            HStack(spacing: 6) {
                ForEach(1...5, id: \.self) { index in
                    Image(systemName: index <= vm.selectedRating ? "star.fill" : "star")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundStyle(index <= vm.selectedRating ? .yellow : .teritaryText)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                if vm.selectedRating == 1 {
                                    vm.selectedRating = 0
                                } else {
                                    vm.selectedRating = index
                                }
                            }
                        }
                }
            }
        }
    }
    
    private func toggleFilters() -> some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 12) {
                toggleButton(
                    label: "In Stock",
                    systemImage: "checkmark.circle",
                    isSelected: vm.showInStockOnly
                ) {
                    vm.showInStockOnly.toggle()
                }

                toggleButton(
                    label: "On Sale",
                    systemImage: "tag.fill",
                    isSelected: vm.showOnlyOnSale
                ) {
                    vm.showOnlyOnSale.toggle()
                }
                
                Spacer()
            }
        }
    }
    
    private func toggleButton(label: String,
                              systemImage: String,
                              isSelected: Bool,
                              action: @escaping () -> Void) -> some View {
        Button(action: {
            withAnimation { action() }
        }) {
            HStack(spacing: 6) {
                Image(systemName: systemImage)
                    .font(.system(size: 14, weight: .semibold))
                Text(label)
                    .font(.system(size: 14, weight: .semibold))
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(
                Capsule()
                    .foregroundStyle(isSelected ? .accent : .clear)
                    .overlay {
                        Capsule()
                            .stroke(.accent, lineWidth: 1)
                    }
            )
            .foregroundStyle(isSelected ? .white : .accent)
        }
    }
    
    private func clearOrApplyFilters() -> some View {
        HStack(spacing: 12) {
            FShopButton(title: "Clear",
                        style: vm.isClearDisabled ? .secondaryDisabled : .secondary, size: .small) {
                withAnimation {
                    vm.clearFilters()
                }
            }
            
            FShopButton(title: "Apply", style: .primary, size: .small) {
                print("Clear")
            }
        }
    }
}

#Preview {
    FilterView(vm: FilterViewModel())
        .environmentObject(CurrencyManager())
}
