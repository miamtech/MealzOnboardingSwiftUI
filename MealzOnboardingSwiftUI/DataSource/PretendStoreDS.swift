//
//  PretendStoreDS.swift
//  MealzOnboardingSwiftUI
//
//  Created by Diarmuid McGonagle on 25/06/2024.
//

import Foundation

class PretendStoreDS {
    private let baseURL = URL(string: "https://api.miam.tech/api/v1/")!

    func fetchStores(completion: @escaping (Result<APIResponseStore, Error>) -> Void) {
        var components = URLComponents(url: baseURL.appendingPathComponent("point-of-sales"), resolvingAgainstBaseURL: false)
        components?.queryItems = [
            URLQueryItem(name: "filter[supplier-id]", value: String(SUPPLIERID))
        ]
        
        guard let productsURL = components?.url else {
            let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            completion(.failure(error))
            return
        }

        let task = URLSession.shared.dataTask(with: productsURL) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "No data received"])
                completion(.failure(error))
                return
            }

            do {
                let apiResponse = try JSONDecoder().decode(APIResponseStore.self, from: data)
                completion(.success(apiResponse))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
}

struct APIResponseStore: Codable {
    let data: [StoreData]
}

struct StoreData: Codable {
    let id: String
    let attributes: StoreAttributes
}

struct StoreAttributes: Codable {
    let name: String
}
