//
//  TabView.swift
//  FunctionalShopApp
//
//  Created by Temur Chitashvili on 13.04.25.
//

import SwiftUI

struct MyTabView: View {
    var body: some View {
        TabView {
            MainListView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }

            FilterView()
                .tabItem {
                    Label("Filter", systemImage: "line.3.horizontal.decrease")
                }

            StatisticsDashboardView()
                .tabItem {
                    Label("Stats", systemImage: "chart.bar.xaxis")
                }

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
    }
}

#Preview {
    MyTabView()
}
