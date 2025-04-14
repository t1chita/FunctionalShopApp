//
//  TabView.swift
//  FunctionalShopApp
//
//  Created by Temur Chitashvili on 13.04.25.
//

import SwiftUI

struct MyTabView: View {
    private let mainListViewModel: MainListViewModel

    init() {
        self.mainListViewModel = Injection.shared.provideMainListViewModel()
    }

    var body: some View {
        TabView {
            MainListView(vm: mainListViewModel)
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
