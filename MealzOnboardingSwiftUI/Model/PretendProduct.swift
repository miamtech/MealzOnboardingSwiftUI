//
//  PretendProduct.swift
//  MealzOnboardingSwiftUI
//
//  Created by didi on 25/10/2023.
//

import Foundation

public class PretendProduct: Identifiable, Codable, Hashable {
    public var id: String
    public var name: String
    public var quantity: Int
    public var price: Double?
    public var identifier: String?
    public var imageUrl: String?
    
    init(
        id: String,
        name: String,
        quantity: Int,
        price: Double? = nil,
        identifier: String? = nil,
        imageUrl: String? = nil
    ) {
        self.id = id
        self.name = name
        self.quantity = quantity
        self.price = price
        self.identifier = identifier
        self.imageUrl = imageUrl
    }
    
    public static func == (lhs: PretendProduct, rhs: PretendProduct) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

