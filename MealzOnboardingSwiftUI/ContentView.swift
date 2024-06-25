//
//  ContentView.swift
//  MealzOnboardingSwiftUI
//
//  Created by Diarmuid McGonagle on 25/06/2024.
//

import SwiftUI

struct ContentView: View {
    @SwiftUI.State private var selectedTab = 0
    @StateObject var userSession = UserSession()
    var body: some View {
        TabView(selection: $selectedTab) {
            HomePageView()
                .tabItem { Label("Home", systemImage: "book.fill") }
                .tag(0)
            StoreSelectorView()
                .tabItem { Label("Store", systemImage: "book.fill") }
                .tag(1)
            ProductSearchView()
                .tabItem { Label("Search", systemImage: "book.fill") }
                .tag(2)
        }.environmentObject(userSession)
    }
}

#Preview {
    ContentView()
}
