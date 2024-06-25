//
//  ProductCard.swift
//  MealzOnboardingSwiftUI
//
//  Created by Diarmuid McGonagle on 25/06/2024.
//

import SwiftUI

struct ProductCard: View {
    @EnvironmentObject var basket: PretendBasket
    let product: PretendProduct
    let updateQuantity: (Int) -> Void
    @State var productQuantity: Int
    init(product: PretendProduct, updateQuantity: @escaping (Int) -> Void) {
        self.product = product
        self.updateQuantity = updateQuantity
        _productQuantity = State(initialValue: product.quantity)
    }
    var body: some View {
        HStack {
            if let pictureURL = URL(string: product.imageUrl ?? "") {
                AsyncImage(url: pictureURL) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                }
                .frame(width: 72, height: 72)
                .padding()
            }
            VStack(alignment: .leading) {
                Text(product.name)
                if let price = product.price, price > 0 {
                    Text(String(price))
                }
                ChangeQuantityButton(productQuantity: $productQuantity)
                    .onChange(of: productQuantity, { updateQuantity(productQuantity)})
            }
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(productQuantity > 0 ? Color.green : Color.clear)
        .onAppear {
            if let basketProduct = basket.items.first(where: { $0.id == product.id }) {
                productQuantity = basketProduct.quantity
            } else { productQuantity = 0 }
        }
    }
    
    struct ChangeQuantityButton: View {
        @Binding var productQuantity: Int
        var body: some View {
            HStack{
                Button(action: { if productQuantity > 0 { productQuantity = productQuantity - 1 } }, label: {
                    Image(systemName: "minus")
                })
                Text(String(productQuantity)).frame(minWidth: 10, alignment: .center)
                Button(action: { productQuantity = productQuantity + 1 }, label: {
                    Image(systemName: "plus")
                })
            }
            .padding()
        }
    }
}

#Preview {
    ProductCard(product: PretendProduct(id: "", name: "Test", quantity: 0), updateQuantity: { _ in })
}
