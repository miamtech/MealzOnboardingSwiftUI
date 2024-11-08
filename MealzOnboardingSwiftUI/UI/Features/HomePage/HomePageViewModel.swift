//
//  HomePageViewModel.swift
//  MealzOnboardingSwiftUI
//
//  Created by Diarmuid McGonagle on 25/06/2024.
//

import Foundation

class HomePageViewModel: ObservableObject {
    @Published var products: [PretendProduct] = []
    @Published var error: String? = nil
    var productEans: [String] = []
    let numberOfProductsBetweenShowingRecipe: Int = 2 // You can work with your PO to determine this
    
    init(currentStore: PretendStore?) {
        if let currentStore = currentStore {
            setProducts(currentStore: currentStore)
        }
    }
    
    func setProducts(currentStore: PretendStore) {
        PretendProductRepository().getProducts(currentStore: currentStore, completion: { result in
            switch result {
            case .success(let products):
                DispatchQueue.main.async { self.products = products }
                
            case .failure(let error):
                DispatchQueue.main.async { self.error = error.localizedDescription }
            }})
    }
    
    // TODO: 5b. Create Rule to show Recipe Cards
    func determineIfMealzCardShouldBeShown(index: Int, currentEan: String?) -> Bool {
        if let ean = currentEan { productEans.append(ean) }
        return (index % numberOfProductsBetweenShowingRecipe) == 0 && index != 0
    }
    
}
