//
//  ProductDetailsViewModel.swift
//  DoorDashPrep
//
//  Created by Anton Bezlyudnyy on 11/1/24.
//

import Foundation
import CoreNetworking

final class ProductDetailsViewModel: ObservableObject {
    private let networkManager: NetworkManagerImpl!
    @Published private(set) var product: ProductDetails?
    
    init(networkManager: NetworkManagerImpl! = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    @MainActor
    func loadDetails(productId: Int) async {
        do {
            product = try await networkManager.makeRequest(session: .shared,
                                                 url: API.Endpoints.productDetails(id: productId).url,
                                                 method: .GET,
                                                 body: nil,
                                                 headers: nil,
                                                 responseType: ProductDetails.self)
        } catch {
            print(error)
        }
    }
}
