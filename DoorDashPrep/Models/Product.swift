//
//  Product.swift
//  DoorDashPrep
//
//  Created by Anton Bezlyudnyy on 10/30/24.
//

import Foundation

struct ProductsResponse: Codable {
    let products: [Product]?
    let total: Int
    let skip: Int
    let limit: Int
}

struct Product: Codable, Identifiable {
    let id: Int
    let title: String?
    let description: String?
    let rating: Double?
    let previewImage: String?

    enum CodingKeys: String, CodingKey {
        case id, title, description, rating
        case previewImage = "thumbnail"
    }
}
