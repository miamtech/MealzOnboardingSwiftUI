//
//  HomePageView.swift
//  MealzOnboardingSwiftUI
//
//  Created by Diarmuid McGonagle on 25/06/2024.
//

import SwiftUI
import mealzcore
import MealziOSSDK

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
    
    // TODO: 5. Add Recipe Cards in View

    struct DefaultProducts: View {
        @EnvironmentObject var basket: PretendBasket
        @ObservedObject var viewModel: HomePageViewModel
        
        init(viewModel: HomePageViewModel) {
            self.viewModel = viewModel
        }
        
        // TODO: 5c. Create Suggestions Criteria based on other products
        struct InjectedMealzRecipeCard: View {
            let eans: [String]
            var body: some View {
                let suggestionsCriteria = SuggestionsCriteria(shelfIngredientsIds: eans, currentIngredientsIds: nil, basketIngredientsIds: nil, groupId: nil)
                return MealzStandaloneRecipeCardSwiftUI(criteria: suggestionsCriteria)
            }
        }
        
        var body: some View {
            ScrollView {
                VStack {
                    // TODO: 5a. Embed Recipe Card With Recipe Id to show
//                    MealzStandaloneRecipeCardSwiftUI(recipeId: "15434")
                    
                    ForEach(Array(viewModel.products.enumerated()), id: \.element.id) { index, product in
                        let thisProduct = basket.items.first(where: { it in it.id == product.id }) ?? product
                        
                        // TODO: 5d. Add StandaloneRecipeCard when Rule true
                        if viewModel.determineIfMealzCardShouldBeShown(index: index, currentEan: thisProduct.ean) {
                            InjectedMealzRecipeCard(eans: viewModel.productEans)
                        }
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

// TODO: 6. Create Custom Recipe Card
// TODO: 6a. Create Mealz Config File & Struct
// TODO: 6b. Create new file to host Recipe Card with boilerplate
// TODO: 6c. Add code for new Recipe Card
// TODO: 6d. Add Recipe Card Options to Config
// TODO: 6e. Add new Recipe Card to Config
// TODO: 6f. Pass config into Standalone Recipe Details
