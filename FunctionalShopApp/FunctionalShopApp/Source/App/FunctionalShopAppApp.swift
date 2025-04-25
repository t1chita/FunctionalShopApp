//
//  FunctionalShopAppApp.swift
//  FunctionalShopApp
//
//  Created by Temur Chitashvili on 11.04.25.
//

import SwiftUI

@main
struct FunctionalShopAppApp: App {
    @StateObject private var currencyManager = CurrencyManager.shared // Access shared instance
    var body: some Scene {
        WindowGroup {
            MyTabView()
                .environmentObject(currencyManager)
        }
    }
}
