//
//  UserConnectionViewModel.swift
//  MealzOnboardingSwiftUI
//
//  Created by Diarmuid McGonagle on 25/06/2024.
//

import Foundation

enum SignInError: Error, LocalizedError {
    case invalidCredentials
    case passwordsNotTheSame
    case unknownError
    
    var errorDescription: String? {
        switch self {
        case .invalidCredentials:
            return "Invalid credentials"
        case .passwordsNotTheSame:
            return "Passwords do not match"
        case .unknownError:
            return "An unknown error occurred"
        }
    }
}

class UserConnectionViewModel: ObservableObject {
    let userRepository = PretendUserRepository()
    
    func signInUser(email: String, password: String) -> Result<PretendUser, Error> {
        // Validate email and password (example validation)
        guard !email.isEmpty, !password.isEmpty else {
            return .failure(SignInError.invalidCredentials)
        }

        // Simulate a network request or local storage lookup
        // For this example, we'll just create a PretendUser and return it
        let user = PretendUser(id: UUID().uuidString, email: email, password: password)
        userRepository.signInUser(user: user)
        
        return .success(user)
    }
    
    func signUpUser(email: String, password: String, reenterPassword: String) -> Result<PretendUser, Error> {
        // Validate email and password (example validation)
        guard !email.isEmpty, !password.isEmpty, !reenterPassword.isEmpty else {
            return .failure(SignInError.invalidCredentials)
        }
        
        guard password != reenterPassword else {
            return .failure(SignInError.passwordsNotTheSame)
        }

        // Simulate a network request or local storage lookup
        // For this example, we'll just create a PretendUser and return it
        let user = PretendUser(id: UUID().uuidString, email: email, password: password)
        userRepository.signInUser(user: user)
        
        return .success(user)
    }
}
