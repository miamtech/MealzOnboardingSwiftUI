//
//  PretendStoreRepository.swift
//  MealzOnboardingSwiftUI
//
//  Created by Diarmuid McGonagle on 25/06/2024.
//

import Foundation

class PretendStoreRepository {
    private let dataSource: PretendStoreDS

    init(dataSource: PretendStoreDS = PretendStoreDS()) {
        self.dataSource = dataSource
    }

    func getStores(completion: @escaping (Result<[PretendStore], Error>) -> Void) {
        dataSource.fetchStores { result in
            switch result {
            case .success(let apiResponse):
                let stores = apiResponse.data.map { PretendStore(id: $0.id, name: $0.attributes.name) }
                completion(.success(stores))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
