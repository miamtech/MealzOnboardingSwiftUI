//
//  CustomRecipeCard.swift
//  MealzOnboardingSwiftUI
//
//  Created by Diarmuid McGonagle on 28/06/2024.
//
import SwiftUI
import mealzcore
import MealziOSSDK

// TODO: 6b. Create new file to host Recipe Card with boilerplate

@available(iOS 14, *)
public struct MyCustomRecipeCardView: CatalogRecipeCardProtocol {
    // TODO: 6c. Add code for new Recipe Card
    public func content(params: CatalogRecipeCardParameters) -> some View {
        VStack {
            Text(params.recipe.title)
            Button(action: { params.onShowRecipeDetails(params.recipe.id) }, label: { Text("Add")})
        }
    }
}
