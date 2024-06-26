//
//  UserConnectionView.swift
//  MealzOnboardingSwiftUI
//
//  Created by Diarmuid McGonagle on 25/06/2024.
//

import SwiftUI

struct UserConnectionView: View {
    @EnvironmentObject var userSession: UserSession
    @StateObject var viewModel = UserConnectionViewModel()
    @State var signInTab: Bool = false
    @State var email: String = ""
    @State var password: String = ""
    @State var reenterPassword: String = ""
    @State var error: String? = nil
    
    func handleResponseFromVM(result: Result<PretendUser, Error>) {
        switch result {
        case .success(let user):
            userSession.setUser(user: user)
        case .failure(let error):
            self.error = error.localizedDescription
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            SignInSignOutTabBar(signInTab: $signInTab)
            if !signInTab {
                SignUpView(
                    email: $email,
                    password: $password,
                    reenterPassword: $reenterPassword,
                    signUpAction: { email, password, reenterPassword in
                        let result = viewModel.signUpUser(email: email, password: password, reenterPassword: reenterPassword)
                        handleResponseFromVM(result: result)
                    })
            } else {
                SignInView(
                    email: $email,
                    password: $password,
                    signInAction: { email, password in
                        let result = viewModel.signInUser(email: email, password: password)
                        handleResponseFromVM(result: result)
                    })
            }
            if let error {
                Text(error)
                    .foregroundStyle(Color.red)
                    .padding()
            }
            Spacer()
        }
    }
    
    struct SignInSignOutTabBar: View {
        @Binding var signInTab: Bool
        var body: some View {
            HStack {
                Button(action: { signInTab = false }, label: {
                    Text("Sign Up")
                        .frame(maxWidth: .infinity)
                })
                .padding()
                .background(Color.cyan)
                Button(action: { signInTab = true }, label: {
                    Text("Sign In")
                        .frame(maxWidth: .infinity)
                })
                .padding()
                .background(Color.green)
            }
            .frame(maxWidth: .infinity)
        }
    }
    
    struct SignInView: View {
        @Binding var email: String
        @Binding var password: String
        let signInAction: (String, String) -> Void
        var body: some View {
            VStack {
                Text("Sign In")
                TextField("Email", text: $email)
                TextField("Password", text: $password)
                Button(action: { signInAction(email, password) }, label: {
                    Text("Submit")
                })
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .background(Color.green)
        }
    }
    
    struct SignUpView: View {
        @Binding var email: String
        @Binding var password: String
        @Binding var reenterPassword: String
        let signUpAction: (String, String, String) -> Void
        var body: some View {
            VStack {
                Text("Sign Up")
                TextField("Email", text: $email)
                TextField("Password", text: $password)
                TextField("Reenter Password", text: $reenterPassword)
                Button(action: { signUpAction(email, password, reenterPassword) }, label: {
                    Text("Submit")
                })
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding()
            .background(Color.cyan)
        }
    }
}

#Preview {
    UserConnectionView()
}
