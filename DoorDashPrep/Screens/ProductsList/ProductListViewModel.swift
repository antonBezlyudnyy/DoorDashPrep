//
//  ProductListViewModel.swift
//  DoorDashPrep
//
//  Created by Anton Bezlyudnyy on 10/30/24.
//

import Foundation
import CoreNetworking

final class ProductListViewModel: ObservableObject {
    private let networkManager: NetworkManagerImpl!
    @Published private(set) var products:[Product] = []
    @Published private(set) var isLoading: Bool = false
    @Published var errorWrapper: ErrorWrapper?
    private var page: Int = 0
    private var totalItems: Int?
    
    init(networkManager: NetworkManagerImpl! = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    @MainActor
    func loadProductsList() async {
        guard totalItems != products.count else {
            return
        }
        isLoading = true
        defer { isLoading = false }
        do {
            let productsResult = try await networkManager.makeRequest(session: .shared,
                                                                      url: API.Endpoints.products(page: page).url,
                                                                      method: .GET,
                                                                      body: nil,
                                                                      headers: nil,
                                                                      responseType: ProductsResponse.self)
            totalItems = productsResult?.total
            page += 1
            products += productsResult?.products ?? []
        } catch {
            errorWrapper = ErrorWrapper(message: error.localizedDescription)
        }
    }
    
    @MainActor
    func reFetch() async {
        page = 0
        products.removeAll()
        await loadProductsList()
    }
    
    func isEndOfPage(product: Product) -> Bool {
        return self.products.last?.id == product.id
    }
}
