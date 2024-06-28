//
//  MealzViewConfig.swift
//  MealzOnboardingSwiftUI
//
//  Created by Diarmuid McGonagle on 28/06/2024.
//

import MealziOSSDK

// TODO: 6a. Create Mealz Config File & Struct
struct MealzViewConfig {
    // TODO: 6d. Add Recipe Card Options to Config
    static let recipeCardConfig = StandaloneRecipeCardConstructor(
        // TODO: 6e. Add new Recipe Card to Config
        recipeCard: TypeSafeCatalogRecipeCard(MyCustomRecipeCardView())
    )
}
