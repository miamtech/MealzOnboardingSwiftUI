//
//  PretendBasket.swift
//  MealzOnboardingSwiftUI
//
//  Created by didi on 25/10/2023.
//

import Foundation

class PretendBasket: ObservableObject {
    @Published var items = [PretendProduct]()

    init(items: [PretendProduct]) {
        self.items = items
    }
    
    func add(addedProduct: PretendProduct) {
        if let existingProductIndex = items.firstIndex(where: { $0.id.isEqual(addedProduct.id) }) {
            let product = items[existingProductIndex]
            product.quantity += 1
        } else {
            items.append(addedProduct)
        }
    }
    
    func updateQuantity(product: PretendProduct, newQuantity: Int) {
        if newQuantity < 1 { remove(removedProductId: product.id) }
        else {
            product.quantity = newQuantity
            if let existingProductIndex = items.firstIndex(where: { $0.id.isEqual(product.id) }) {
                items[existingProductIndex] = product
            } else {
                items.append(product)
            }
        }
    }

    func remove(removedProductId: String) {
        guard let productIndex = items.firstIndex(where: { $0.id.isEqual(removedProductId) }) else {
            return
        }
        items.remove(at: productIndex)
    }

    func removeAll() {
        items.removeAll()
    }
    
    func totalPrice() -> Double {
        return items.reduce(0) { $0 + ($1.price ?? 0) * Double($1.quantity) }
    }
    
    func totalPriceFormatted(currencyCode: String = "EUR") -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currencyCode
        formatter.maximumFractionDigits = 2
        
        return formatter.string(from: NSNumber(value: totalPrice())) ?? "\(currencyCode) 0.00"
    }
}
