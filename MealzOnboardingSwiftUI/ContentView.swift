//
//  ContentView.swift
//  MealzOnboardingSwiftUI
//
//  Created by Diarmuid McGonagle on 25/06/2024.
//

import SwiftUI

struct ContentView: View {
    @State var stores: [PretendStore] = []
    @State var products: [PretendProduct] = []
    var body: some View {
        ScrollView {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
                Button(action: {
                    PretendProductRepository().getProducts(completion: { result in
                        switch result {
                        case .success(let foundProducts):
                            print("Fetched products: \(foundProducts)")
                            products = foundProducts
                            // Handle the stores (e.g., update the UI)
                            
                        case .failure(let error):
                            print("Failed to fetch products: \(error.localizedDescription)")
                            // Handle the error (e.g., show an error message to the user)
                        }
                    })
                }, label: {
                    Text("get products")
                })
                Button(action: {
                    PretendStoreRepository().getStores(completion: { result in
                        switch result {
                        case .success(let foundStores):
                            print("Fetched stores: \(foundStores)")
                            stores = Array(foundStores.prefix(10))
                            // Handle the stores (e.g., update the UI)
                            
                        case .failure(let error):
                            print("Failed to fetch stores: \(error.localizedDescription)")
                            // Handle the error (e.g., show an error message to the user)
                        }
                    })
                }, label: {
                    Text("get stores")
                })
                ForEach(stores) { store in
                    Text("\(store.name)-\(store.id)")
                }
                ForEach(products) { product in
                    Text("\(product.name)-\(product.id)")
                }
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
