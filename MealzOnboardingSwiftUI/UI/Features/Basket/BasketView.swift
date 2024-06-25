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
        if basket.items.count > 0 {
            ScrollView {
                VStack {
                    HStack {
                        Text("Your Basket Total is \(basket.totalPriceFormatted())")
                        Spacer()
                        Button(action: basket.removeAll, label: {
                            Image(systemName: "trash.slash")
                        }).foregroundStyle(Color.red)
                    }.padding()
                    ForEach(basket.items) { product in
                        ProductCard(product: product, updateQuantity: { newQuantity in
                            basket.updateQuantity(product: product, newQuantity: newQuantity)
                        })
                    }
                }
            }
        } else {
            Text("Add items to your basket!")
        }
    }
}

#Preview {
    BasketView()
}
