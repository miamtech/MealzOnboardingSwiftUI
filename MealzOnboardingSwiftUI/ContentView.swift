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
    @StateObject var basket = PretendBasket(items: [])
    
    var body: some View {
        VStack {
            if userSession.user != nil {
                TabView(selection: $selectedTab) {
                    HomePageView()
                        .tabItem { Label("Home", systemImage: "house") }
                        .tag(0)
                    StoreSelectorView()
                        .tabItem { Label("Store", systemImage: "storefront") }
                        .tag(1)
                    ProductSearchView()
                        .tabItem { Label("Search", systemImage: "magnifyingglass") }
                        .tag(2)
                    BasketView()
                        .tabItem { Label("Basket", systemImage: "basket") }
                        .tag(3)
                }
            } else {
                UserConnectionView()
            }
        }
        .environmentObject(userSession)
        .environmentObject(basket)
    }
}

#Preview {
    ContentView()
}
