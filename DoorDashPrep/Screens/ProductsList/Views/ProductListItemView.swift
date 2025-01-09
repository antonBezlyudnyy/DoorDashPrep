//
//  ProductListItemView.swift
//  DoorDashPrep
//
//  Created by Anton Bezlyudnyy on 10/30/24.
//

import SwiftUI

struct ProductListItemView: View {
    let product: Product
    
    init(product: Product) {
        self.product = product
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5){
                if let title = product.title {
                    Text(title)
                        .bold()
                }
                if let description = product.description {
                    Text(description)
                }
            }
            Spacer()
            if let previewImage = product.previewImage {
                VStack(alignment: .center) {
                    AsyncImage(url: URL(string: previewImage)) { image in
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    } placeholder: {
                        ProgressView()
                            .progressViewStyle(.circular)
                    }
                    .frame(maxWidth: 100, maxHeight: 100)
                    if let rating = product.rating {
                        HStack (spacing: 2) {
                            Image(systemName: "star.fill")
                            Text("\(rating, specifier: "%.1f")")
                                .bold()
                        }
                    }
                }
            }
        }
        .font(.system(size: 12))
        .frame(height: 120)
    }
}

#Preview {
    ProductListItemView(product: Product(id: 1,
                                         title: "1",
                                         description: "some",
                                         rating: 4.95,
                                         previewImage: ""))
}
