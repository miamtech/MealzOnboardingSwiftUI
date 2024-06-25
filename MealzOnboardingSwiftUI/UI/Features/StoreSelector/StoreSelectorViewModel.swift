//
//  StoreSelectorViewModel.swift
//  MealzOnboardingSwiftUI
//
//  Created by Diarmuid McGonagle on 25/06/2024.
//

import Foundation

class StoreSelectorViewModel: ObservableObject {
    @Published var stores: [PretendStore] = []
    @Published var error: String? = nil
    
    init() {
        setStores()
    }
    
    func setStores() {
        PretendStoreRepository().getStores(completion: { result in
            switch result {
            case .success(let stores):
                DispatchQueue.main.async { self.stores = Array(stores.prefix(10)) }
                
            case .failure(let error):
                DispatchQueue.main.async { self.error = error.localizedDescription }
            }
        })
    }
}
