//
//  UserSession.swift
//  MealzOnboardingSwiftUI
//
//  Created by Diarmuid McGonagle on 25/06/2024.
//

import Foundation

class UserSession: ObservableObject {
    @Published var user: PretendUser?
    @Published var selectedStore: PretendStore?
    
    let userRepository = PretendUserRepository()
    
    init() {
        if let user = userRepository.getStoredUser() { setUser(user: user) }
        if let selectedStore { setStore(store: selectedStore) }
    }
    
    func disconnectUser() {
        user = nil
        userRepository.deleteStoredUser()
    }
    
    func setUser(user: PretendUser) {
        // TODO e. Call Mealz Function
        self.user = user
    }
    
    func setStore(store: PretendStore) {
        // TODO f. Call Mealz Function
        self.selectedStore = store
    }
}
