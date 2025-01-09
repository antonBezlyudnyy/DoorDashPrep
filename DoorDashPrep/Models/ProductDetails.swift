//
//  ProductDetails.swift
//  DoorDashPrep
//
//  Created by Anton Bezlyudnyy on 10/30/24.
//

import Foundation

struct ProductDetails: Codable {
    let id: Int
    let title: String?
    let description: String?
    let price: Double?
    let discount: Double?
    let rating: Double?
    let brand: String?
    let category: String?
    let images: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id, title, description, price, rating, brand, category, images
        case discount = "discountPercentage"
    }
}
