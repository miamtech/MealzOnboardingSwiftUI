//
//  PretendProductRepository.swift
//  MealzOnboardingSwiftUI
//
//  Created by Diarmuid McGonagle on 25/06/2024.
//

import Foundation

class PretendProductRepository {
    private let dataSource: PretendProductDS

    init(dataSource: PretendProductDS = PretendProductDS()) {
        self.dataSource = dataSource
    }

    func getProducts(
        currentStore: PretendStore,
        completion: @escaping (Result<[PretendProduct], Error>) -> Void
    ) {
        dataSource.fetchProducts(
            currentPOS: currentStore.id,
            ingredientId: "1",
            searchText: nil
        ) { result in
            switch result {
            case .success(let apiResponse):
                let stores = apiResponse.data.map {
                    PretendProduct(
                        id: $0.id,
                        name: $0.attributes.name,
                        quantity: 0,
                        price: Double($0.attributes.unitPrice),
                        imageUrl: $0.attributes.image
                    )
                }
                completion(.success(stores))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func searchProducts(
        currentStore: PretendStore,
        searchText: String,
        completion: @escaping (Result<[PretendProduct], Error>) -> Void
    ) {
        dataSource.fetchProducts(
            currentPOS: currentStore.id,
            ingredientId: nil,
            searchText: searchText
        ) { result in
            switch result {
            case .success(let apiResponse):
                let stores = apiResponse.data.map {
                    PretendProduct(
                        id: $0.id,
                        name: $0.attributes.name,
                        quantity: 0,
                        price: Double($0.attributes.unitPrice),
                        imageUrl: $0.attributes.image
                    )
                }
                completion(.success(stores))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
