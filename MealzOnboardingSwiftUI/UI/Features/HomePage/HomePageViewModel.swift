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
}
