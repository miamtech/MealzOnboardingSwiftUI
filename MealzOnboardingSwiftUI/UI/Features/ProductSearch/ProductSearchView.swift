//
//  ProductSearchView.swift
//  MealzOnboardingSwiftUI
//
//  Created by Diarmuid McGonagle on 25/06/2024.
//

import SwiftUI

struct ProductSearchView: View {
    @EnvironmentObject var userSession: UserSession
    @EnvironmentObject var basket: PretendBasket
    
    var body: some View {
        if let currentStore = userSession.selectedStore {
            SearchAndResults(currentStore: currentStore)
                .environmentObject(basket)
        } else {
            StoreSelectorView()
        }
    }
    
    struct SearchAndResults: View {
        @EnvironmentObject var basket: PretendBasket
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
                    .padding()
                    if viewModel.products.count > 0 {
                        ForEach(viewModel.products) { product in
                            let thisProduct = basket.items.first(where: { it in it.id == product.id }) ?? product
                            ProductCard(product: thisProduct, updateQuantity: { newQuantity in
                                basket.updateQuantity(product: thisProduct, newQuantity: newQuantity)
                            })
                        }
                    } else {
                        Spacer()
                        Text("Search for a product")
                        Spacer()
                    }
                }
            }
        }
    }
}

#Preview {
    ProductSearchView()
}
