//
//  PretendStore.swift
//  MealzOnboardingSwiftUI
//
//  Created by Diarmuid McGonagle on 25/06/2024.
//

import Foundation

public class PretendStore: Identifiable, Codable, Hashable {
    public var id: String
    public var name: String
    
    init(id: String, name: String) {
        self.id = id
        self.name = name
    }
    
    public static func == (lhs: PretendStore, rhs: PretendStore) -> Bool {
        return lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

