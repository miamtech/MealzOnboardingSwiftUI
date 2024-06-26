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
        self.user = userRepository.getStoredUser()
    }
    
    func disconnectUser() {
        user = nil
        userRepository.deleteStoredUser()
    }
    
    func setUser(user: PretendUser) {
        self.user = user
    }
    
    func setStore(store: PretendStore) {
        self.selectedStore = store
    }
}
