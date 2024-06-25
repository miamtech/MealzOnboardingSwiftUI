//
//  BasketView.swift
//  MealzOnboardingSwiftUI
//
//  Created by Diarmuid McGonagle on 25/06/2024.
//

import SwiftUI

struct BasketView: View {
    @EnvironmentObject var basket: PretendBasket
    var body: some View {
        ScrollView {
            VStack {
                ForEach(basket.items) { product in
                    ProductCard(product: product, updateQuantity: { newQuantity in
                        basket.updateQuantity(product: product, newQuantity: newQuantity)
                    })
                }
            }
        }
    }
}

#Preview {
    BasketView()
}
