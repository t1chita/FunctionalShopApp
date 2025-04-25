//
//  FilterView.swift
//  FunctionalShopApp
//
//  Created by Temur Chitashvili on 12.04.25.
//

import SwiftUI

struct FilterView: View {
    @State var offset: CGFloat = 0
    private let maxValue: CGFloat = 1000 // Maximum value in GEL
    @State var selectedValue: CGFloat = 0
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
                LazyHStack {
                    ForEach(vm.categories, id: \.self) { category in
                        categoryButton(category)
                            .id(category)
                    }
                }
                .padding(.horizontal)
            }
            .frame(height: 26)
            .scrollIndicators(.hidden)
            .onChange(of: vm.selectedCategory) { oldValue, newValue in
                withAnimation {
                    proxy.scrollTo(newValue, anchor: .center)
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
                
                Text(currencyManager.format(price: selectedValue))
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
                        .frame(width: max(0, offset + 20), height: 16)
                    
                    Circle()
                        .fill(.primaryButton)
                        .frame(width: 24, height: 24)
                        .overlay {
                            Circle()
                                .stroke(lineWidth: 2)
                                .foregroundStyle(.accent)
                        }
                        .offset(x: max(0, min(offset, totalWidth)))
                        .gesture(
                            DragGesture()
                                .onChanged { value in
                                    let newOffset = value.location.x - 8
                                    self.offset = max(0, min(newOffset, totalWidth))
                                    self.selectedValue = (offset / totalWidth) * maxValue
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
}

#Preview {
    FilterView(vm: FilterViewModel())
        .environmentObject(CurrencyManager())
}
