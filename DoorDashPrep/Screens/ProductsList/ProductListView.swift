//
//  ProductListView.swift
//  DoorDashPrep
//
//  Created by Anton Bezlyudnyy on 10/30/24.
//

import SwiftUI

struct ProductListView: View {
    @StateObject private var viewModel: ProductListViewModel = ProductListViewModel()
   
    var body: some View {
        List {
            ForEach(viewModel.products) { product in
                ZStack {
                    ProductListItemView(product: product)
                        .background {
                            NavigationLink("",
                                           destination: ProductDetailsView(productId: product.id)
                                .navigationTitle(product.title ?? "Details"))
                            .opacity(0)
                        }
                        .task {
                            if viewModel.isEndOfPage(product: product) && !viewModel.isLoading {
                                await viewModel.loadProductsList()
                            }
                        }
                }
            }
        }
        .overlay(alignment: .bottom) {
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(.circular)
            }
        }
        .refreshable {
            await viewModel.reFetch()
        }
        .task {
            await viewModel.loadProductsList()
        }
        .navigationTitle("Products List")
        .alert(item: $viewModel.errorWrapper) { error in
            Alert(
                title: Text("Error"),
                message: Text(error.message),
                dismissButton: .default(Text("OK"), action: {
                    viewModel.errorWrapper = nil
                })
            )
        }
    }
}

#Preview {
    ProductListView()
}
