//
//  PretendProductDS.swift
//  MealzOnboardingSwiftUI
//
//  Created by Diarmuid McGonagle on 25/06/2024.
//

import Foundation

class PretendProductRemoteDS {
    func fetchProducts(currentPOS: String, searchText: String?, completion: @escaping (Result<APIResponseProduct, Error>) -> Void) {
        var components = URLComponents(url: BASE_URL.appendingPathComponent("items"), resolvingAgainstBaseURL: false)
        components?.path.append("/search")
        components?.queryItems = [
            URLQueryItem(name: "point_of_sale_id", value: currentPOS),
        ]
        if searchText != nil {
            components?.queryItems?.append(URLQueryItem(name: "name", value: searchText))
        } else {
            components?.queryItems?.append(URLQueryItem(name: "name", value: "creme"))
        }
        
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
                let products = try JSONDecoder().decode(APIResponseProduct.self, from: data)
                completion(.success(products))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
    }
}

struct APIResponseProduct: Codable {
    let data: [ProductData]
}

struct ProductData: Codable {
    let id: String
    let attributes: ProductAttributes
}

struct ProductAttributes: Codable {
    let name: String
    let image: String?
    let unitPrice: String
    let ean: String
    
    enum CodingKeys: String, CodingKey {
        case name, image, ean
        case unitPrice = "unit-price"
    }
}
