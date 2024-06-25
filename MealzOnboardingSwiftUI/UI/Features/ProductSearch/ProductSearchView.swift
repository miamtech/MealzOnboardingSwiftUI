//
//  ProductSearchView.swift
//  MealzOnboardingSwiftUI
//
//  Created by Diarmuid McGonagle on 25/06/2024.
//

import SwiftUI

struct ProductSearchView: View {
    @EnvironmentObject var userSession: UserSession
    
    var body: some View {
        if let currentStore = userSession.selectedStore {
            SearchAndResults(currentStore: currentStore)
        } else {
            StoreSelectorView()
        }
    }
    
    struct SearchAndResults: View {
        @StateObject var viewModel = ProductSearchViewModel()
        @State var searchText: String = ""
        var currentStore: PretendStore
        var body: some View {
            ScrollView {
                VStack {
                    TextField(text: $searchText, label: {
                        Text("Search for a product")
                    }).onChange(of: searchText, {
                        if searchText.count > 3 { viewModel.startSearch(currentStore: currentStore, keyword: searchText) }
                    })
                    ForEach(viewModel.products) { product in
                        Text("\(product.name)-\(product.id)")
                    }
                }
            }
        }
    }
}

#Preview {
    ProductSearchView()
}
