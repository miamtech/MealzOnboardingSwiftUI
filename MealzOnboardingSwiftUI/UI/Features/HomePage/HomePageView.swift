//
//  HomePageView.swift
//  MealzOnboardingSwiftUI
//
//  Created by Diarmuid McGonagle on 25/06/2024.
//

import SwiftUI

struct HomePageView: View {
    @EnvironmentObject var userSession: UserSession
    @StateObject var viewModel: HomePageViewModel = HomePageViewModel(currentStore: nil)

    var body: some View {
        if let currentStore = userSession.selectedStore {
            VStack {
                Text("Welcome to \(currentStore.name.capitalized)")
                    .padding()
                DefaultProducts(currentStore: currentStore, viewModel: viewModel)
                    .onChange(of: userSession.selectedStore, {
                        if let store = userSession.selectedStore {
                            viewModel.setProducts(currentStore: store)
                        }
                    })
            }
        } else {
            StoreSelectorView()
        }
    }
    
    struct DefaultProducts: View {
        @ObservedObject var viewModel: HomePageViewModel
        
        init(currentStore: PretendStore, viewModel: HomePageViewModel) {
            self.viewModel = viewModel
        }
        var body: some View {
            ScrollView {
                VStack {
                    ForEach(viewModel.products) { product in
                        Text("\(product.name)-\(product.id)")
                    }
                }
            }
        }
    }
}

#Preview {
    HomePageView()
}
