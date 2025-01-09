//
//  ProductDetailsView.swift
//  DoorDashPrep
//
//  Created by Anton Bezlyudnyy on 10/30/24.
//

import SwiftUI

struct ProductDetailsView: View {
    var productId: Int!
    @StateObject private var viewModel: ProductDetailsViewModel = ProductDetailsViewModel()
    
    init(productId: Int!) {
        self.productId = productId
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 5) {
                if let product = viewModel.product {
                    CarouselView(imageURLs: product.images)
                        .padding(.bottom)
                    if let price = product.price {
                        Text("Price: \(price, specifier: "%.2f")")
                    }
                    if let discount = product.discount {
                        Text("Discount: \(discount, specifier: "%.2f")")
                    }
                    if let rating = product.rating {
                        Text("Rating: \(rating, specifier: "%.1f")")
                    }
                    if let brand = product.brand {
                        Text("Brand: \(brand)")
                    }
                    if let category = product.category {
                        Text("Category: \(category)")
                    }
                    if let description = product.description {
                        Text("About")
                            .bold()
                            .padding(.top)
                        Text(description)
                    }
                }
                Spacer()
            }
            .padding()
            .font(.system(size: 12))
        }
        .task {
            await viewModel.loadDetails(productId: productId)
        }
    }
}

#Preview {
    ProductDetailsView(productId: 1)
}
