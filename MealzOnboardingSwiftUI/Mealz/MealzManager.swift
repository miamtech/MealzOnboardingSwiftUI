//
//  MealzManager.swift
//  MealzOnboardingSwiftUI
//
//  Created by Diarmuid McGonagle on 26/06/2024.
//

import Foundation
import mealzcore

public class MealzManager {
    // Will contain calls to Miam SDK core class for modules (User, Basket, Store...)
    
    public static let sharedInstance = MealzManager()
    
    // TODO: 3. Set SupplierKey, Store & User Id
    // TODO 3a. Copy & paste supplierID into variable
    let supplierKey = "ewoJInN1cHBsaWVyX2lkIjogIjE0IiwKCSJwbGF1c2libGVfZG9tYWluZSI6ICJtaWFtLnRlc3QiLAoJIm1pYW1fb3JpZ2luIjogIm1pYW0iLAoJIm9yaWdpbiI6ICJtaWFtIiwKCSJtaWFtX2Vudmlyb25tZW50IjogIlVBVCIKfQ=="

    // TODO 3b. Init Mealz
    private init() {
        Mealz.shared.Core(init: { coreBuilder in
            // set supplier key
            coreBuilder.sdkRequirement(init: { requirementBuilder in
                requirementBuilder.key = self.supplierKey
            })
            // TODO: c. Add Subscriptions
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
    
    // TODO: 4a. Create conversion method between your Product class & Mealz SupplierProduct
    
    // TODO: 4b. Create Class that implements BasketPublisher, BasketSubscriber
    // TODO: 4b1. Implement init with initialvalue
    // TODO: 4b2. Implement onBasketUpdate
    // TODO: 4b1. Implement receive
    
    // TODO: 4d. Handle Payment
}
