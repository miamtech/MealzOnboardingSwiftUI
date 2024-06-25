//
//  HomePageView.swift
//  MealzOnboardingSwiftUI
//
//  Created by Diarmuid McGonagle on 25/06/2024.
//

import SwiftUI

struct HomePageView: View {
    @EnvironmentObject var userSession: UserSession
    @EnvironmentObject var basket: PretendBasket
    @StateObject var viewModel: HomePageViewModel = HomePageViewModel(currentStore: nil)

    var body: some View {
        VStack {
            if let currentStore = userSession.selectedStore {
                VStack {
                    Text("Welcome to \(currentStore.name.capitalized)")
                        .padding()
                    DefaultProducts(viewModel: viewModel)
                        .environmentObject(basket)
                }
            } else {
                StoreSelectorView()
            }
        }.onChange(of: userSession.selectedStore, {
            if let store = userSession.selectedStore {
                viewModel.setProducts(currentStore: store)
            }
        })
    }
    
    struct DefaultProducts: View {
        @EnvironmentObject var basket: PretendBasket
        @ObservedObject var viewModel: HomePageViewModel
        
        init(viewModel: HomePageViewModel) {
            self.viewModel = viewModel
        }
        var body: some View {
            ScrollView {
                VStack {
                    ForEach(viewModel.products) { product in
                        let thisProduct = basket.items.first(where: { it in it.id == product.id }) ?? product
                        ProductCard(product: thisProduct, updateQuantity: { newQuantity in
                            basket.updateQuantity(product: thisProduct, newQuantity: newQuantity)
                        })
                    }
                }
            }
        }
    }
}

#Preview {
    HomePageView()
}
