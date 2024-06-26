//
//  StoreSelectorView.swift
//  MealzOnboardingSwiftUI
//
//  Created by Diarmuid McGonagle on 25/06/2024.
//

import SwiftUI

struct StoreSelectorView: View {
    @EnvironmentObject var userSession: UserSession
    @StateObject var viewModel = StoreSelectorViewModel()
    var body: some View {
        ScrollView {
            VStack {
                Text("Choose your store")
                ForEach(viewModel.stores) { store in
                    Store(store: store, currentlySelected: userSession.selectedStore == store) {
                        userSession.selectedStore = store
                    }
                }
            }
        }
    }
    
    struct Store: View {
        let store: PretendStore
        let currentlySelected: Bool
        let selectStore: () -> Void
        var body: some View {
            Button(action: selectStore, label: {
                HStack {
                    Image(systemName: "storefront")
                    Text(store.name.capitalized)
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(currentlySelected ? Color.cyan : Color.clear)
            })
        }
    }
}

#Preview {
    StoreSelectorView()
}
