//
//  ProductSearchViewModel.swift
//  MealzOnboardingSwiftUI
//
//  Created by Diarmuid McGonagle on 25/06/2024.
//

import Foundation

class ProductSearchViewModel: ObservableObject {
    @Published var products: [PretendProduct] = []
    @Published var error: String? = nil
    
    init() {}
    
    func startSearch(currentStore: PretendStore, keyword: String) {
        PretendProductRepository().searchProducts(currentStore: currentStore, searchText: keyword, completion: { result in
            switch result {
            case .success(let products):
                DispatchQueue.main.async { self.products = products }
                
            case .failure(let error):
                DispatchQueue.main.async { self.error = error.localizedDescription }
            }})
    }
}
