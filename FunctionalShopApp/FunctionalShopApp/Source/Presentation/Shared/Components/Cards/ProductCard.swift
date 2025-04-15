//
//  ProductCard.swift
//  FunctionalShopApp
//
//  Created by Temur Chitashvili on 14.04.25.
//

import SwiftUI

struct ProductCard: View {
    let product: Product
    @StateObject private var currencyManager = CurrencyManager.shared // Access shared instance
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            productImage()
            
            productDesc()
                
        }
        .background(
            RoundedRectangle(cornerRadius: 16)
                .foregroundStyle(.cardBackground)
        )
    }
    
    private func productImage() -> some View {
        CachedImage(url: product.imageURL) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(maxWidth: .infinity)
                    .frame(height: 80)
            case .success(let image):
                image
                    .resizable()
                    .frame(height: 180)
                    .frame(maxWidth: .infinity)
                    .scaledToFit()
                    .cornerRadius(12)
            case .failure( _ ):
                Image(systemName: "xmark")
                    .symbolVariant(.circle.fill)
                    .foregroundStyle(.red)
                    .frame(height: 180)
                    .frame(maxWidth: .infinity)
            @unknown default:
                EmptyView()
            }
        }
        .padding(.horizontal, 8)
        .padding(.top, 8)
    }
    
    private func productDesc() -> some View {
        VStack(alignment: .leading,spacing: 12) {
        VStack(alignment: .leading,spacing: 4) {
            HStack {
                FShopText(text: product.name, style: .header)
                
                Spacer()
                
                FShopCardText(text: product.category, style: .body)
                .padding(6)
                .padding(.horizontal, 4)
                .background(
                    Capsule()
                            .stroke(lineWidth: 1)
                            .foregroundStyle(.accent)
                )
            }
            HStack(spacing: 4) {
                FShopCardText(text: formattedPrice(), style: .body)
                    .strikethrough(product.isOnSale, color: .red)
                
                if product.isOnSale  {
                    FShopCardText(text: saledFormattedPrice(), style: .body)
                        .foregroundStyle(.green)
                }
            }
            
            FShopButton(title: "See More", style: .primary, size: .small) {
                print("Button Tapped")
            }
        }
        }
        .padding(.horizontal, 12)
        .padding(.bottom, 8)
    }
    
    
    private func formattedPrice() -> String {
        // Convert the price to the current currency and format it
        let convertedPrice = currencyManager.convertPrice(product.price, from: .usd)
        return currencyManager.format(price: convertedPrice)
    }
    
    private func saledFormattedPrice() -> String {
        // Convert the price to the current currency and format it
        let convertedPrice = currencyManager.convertPrice(product.price.saledPrice(), from: .usd)
        return currencyManager.format(price: convertedPrice)
    }
}

enum AppCurrency: String, CaseIterable, Identifiable {
    case usd = "USD"
    case eur = "EUR"
    case gel = "GEL"

    var id: String { rawValue }

    var symbol: String {
        switch self {
        case .usd: return "$"
        case .eur: return "€"
        case .gel: return "₾"
        }
    }

    var localeIdentifier: String {
        switch self {
        case .usd: return "en_US"
        case .eur: return "de_DE"
        case .gel: return "ka_GE"
        }
    }
}
final class CurrencyManager: ObservableObject {
    static let shared = CurrencyManager()

    @AppStorage("selectedCurrency") private var storedCurrency: String = AppCurrency.usd.rawValue

    var currentCurrency: AppCurrency {
        get { AppCurrency(rawValue: storedCurrency) ?? .usd }
        set { storedCurrency = newValue.rawValue }
    }

    func format(price: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currentCurrency.rawValue
        formatter.locale = Locale(identifier: currentCurrency.localeIdentifier)
        return formatter.string(from: NSNumber(value: price)) ?? "\(price)"
    }

    func convertPrice(_ price: Double, from baseCurrency: AppCurrency) -> Double {
        // If the price is already in the target currency, return the price as is
        if baseCurrency == currentCurrency {
            return price
        } else {
            // Convert the price to the current currency
            let conversionRate = getConversionRate(for: currentCurrency)
            return price * conversionRate
        }
    }

    private func getConversionRate(for currency: AppCurrency) -> Double {
        // Here you would integrate an actual currency conversion API
        switch currency {
        case .usd:
            return 1.0 // USD to USD rate is 1
        case .eur:
            return 0.85 // Example rate, replace with actual logic
        // Add other currencies as needed
        default:
            return 1.0
        }
    }
}
#Preview {
    ZStack {
        Color.background
            .ignoresSafeArea()
        ProductCard(product: Product.MOCK_PRODUCT)
            .padding(.horizontal, 16)
    }
}

extension Double {
    func saledPrice() -> Double {
        self * 0.8
    }
}
