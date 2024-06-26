//
//  MealzManager.swift
//  MealzOnboardingSwiftUI
//
//  Created by Diarmuid McGonagle on 26/06/2024.
//

import Foundation
import Combine
import mealzcore

public class MealzManager {
    // Will contain calls to Miam SDK core class for modules (User, Basket, Store...)
    
    public static let sharedInstance = MealzManager()
    
    // TODO: 3. Set SupplierKey, Store & User Id
    // TODO 3a. Copy & paste supplierID into variable
    let supplierKey = "ewoJInN1cHBsaWVyX2lkIjogIjE0IiwKCSJwbGF1c2libGVfZG9tYWluZSI6ICJtaWFtLnRlc3QiLAoJIm1pYW1fb3JpZ2luIjogIm1pYW0iLAoJIm9yaWdpbiI6ICJtaWFtIiwKCSJtaWFtX2Vudmlyb25tZW50IjogIlVBVCIKfQ=="
    
    // pass in your active basket
    let demoBasketService = DemoBasketService(initialBasketList: PretendBasket.shared.items)

    // TODO 3b. Init Mealz
    private init() {
        Mealz.shared.Core(init: { coreBuilder in
            // set supplier key
            coreBuilder.sdkRequirement(init: { requirementBuilder in
                requirementBuilder.key = self.supplierKey
            })
            // TODO: 4c. Add Subscriptions
            coreBuilder.subscriptions(init:  { subscriptionBuilder in
                subscriptionBuilder.basket(init: { [self] basketSubscriptionBuilder in
                    // subscribe
                    basketSubscriptionBuilder.subscribe(subscriber: demoBasketService)
                    // push updates
                    basketSubscriptionBuilder.register(publisher: demoBasketService)
                })
            })
        })
    }
    
    // TODO 3c. Create function to set the Store
    func updateStoreId(storeId: String) {
        Mealz.shared.user.setStoreWithMealzIdWithCallBack(storeId: storeId) {}
    }

    // TODO 3d. Create function to set the user
    func updateUserId(userId: String) {
        Mealz.shared.user.updateUserId(userId: userId, authorization: Authorization.userId)
    }
    
    // TODO: 4. Set Basket Synchro
    
    // TODO: 4d. Handle Payment
    func handlePayment(totalPrice: Double) {
        Mealz.shared.payment.paymentStarted(
            totalAmount: totalPrice,
            totalProductCount: KotlinInt(integerLiteral: PretendBasket.shared.items.count),
            clientOrderId: nil // pass in the ID from your order 
        )
    }
}

// TODO: 4a. Create conversion method between your Product class & Mealz SupplierProduct
func groceryProductToSupplierProduct(product: PretendProduct) -> SupplierProduct {
    return SupplierProduct(
        id: product.id,
        quantity: Int32(product.quantity),
        name: product.name,
        productIdentifier: product.identifier,
        imageURL: product.imageUrl)
}

func supplierProductToGroceryProduct(product: SupplierProduct) -> PretendProduct {
    return PretendProduct(
        id: product.id,
        name: product.name ?? "",
        quantity: Int(product.quantity),
        identifier: product.productIdentifier,
        imageUrl: product.imageURL)
}

// TODO: 4b. Create Class that implements BasketPublisher, BasketSubscriber
class DemoBasketService: BasketSubscriber, BasketPublisher {
    var initialValue: [SupplierProduct]
    private var cancellable: AnyCancellable? // used to create stream between mealz basket & our own
    
    // TODO: 4b1. Implement init with initialvalue
    init(initialBasketList: [PretendProduct]) {
        if initialBasketList.count > 0 {
            // Now convert (safely) if we have products
            self.initialValue = initialBasketList.map { groceryProductToSupplierProduct(product: $0) }
        } else {
            self.initialValue = []
        }
    }
    
    // TODO: 4b2. Implement onBasketUpdate
    func onBasketUpdate(sendUpdateToSDK: @escaping ([SupplierProduct]) -> Void) {
        cancellable = PretendBasket.shared.$items.sink { receiveValue in
            `sendUpdateToSDK`(
                receiveValue.map { groceryProductToSupplierProduct(product: $0) }
            )
        }
    }
    
    // TODO: 4b3. Implement receive
    func receive(event: [SupplierProduct]) {
        updateBasketFromExternalSource(products: event)
    }
    
    private func updateBasketFromExternalSource(products: [SupplierProduct]) {
        // we need to update the basket all at once, otherwise we will have issues with Mealz updating too frequently
        var basketCopy = PretendBasket.shared.items
        
        for product in products {
            // check if we already have the product to remove or update info
            if let productToUpdateIndex = PretendBasket.shared.items.firstIndex(where: { $0.id == product.id }) {
                if product.quantity == 0 { // we know an item is deleted if the qty is 0
                    if basketCopy.indices.contains(productToUpdateIndex) {
                        basketCopy.remove(at: productToUpdateIndex)
                    }
                } else {
                    let item = PretendBasket.shared.items[productToUpdateIndex]
                    basketCopy[productToUpdateIndex] = PretendProduct( // your product
                        id: product.id,
                        name: product.name ?? item.name,
                        quantity: Int(product.quantity),
                        imageUrl: product.imageURL ?? item.imageUrl)
                }
            } else { // otherwise add it to the client basket
                let newProduct = PretendProduct( // your product
                    id: product.id,
                    name: product.name ?? "product",
                    quantity: Int(product.quantity),
                    imageUrl: product.imageURL
                )
                basketCopy.append(newProduct)
            }
        }
        // update your basket after all operations
        PretendBasket.shared.items = basketCopy
    }
}
