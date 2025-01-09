//
//  API.swift
//  DoorDashPrep
//
//  Created by Anton Bezlyudnyy on 10/30/24.
//

import Foundation

struct API {
    static let host: String = "dummyjson.com"
    static let productsLimit: Int = 10
    
    
    enum Endpoints {
        case products(limit: Int = API.productsLimit, page: Int)
        case productDetails(id: Int)
        
        
        private var path: String {
            switch self {
            case .products(_ , _):
                return "/products"
            case .productDetails(let id):
                return "/products/\(id)"
            }
        }
        
        private var queryItems: [String : String]? {
            switch self {
            case .products(let limit, let page):
                // jump across downloaded elements
                let skip = page * limit
                return ["limit" : "\(limit)",
                        "skip" : "\(skip)"]
            case .productDetails(_ ):
                return nil
            }
        }
        
        var url: URL? {
            var urlComponents: URLComponents = URLComponents()
            urlComponents.scheme = "https"
            urlComponents.host = API.host
            urlComponents.path = path
            var requestQueryItems: [URLQueryItem] = []
            queryItems?.forEach({ item in
                requestQueryItems.append(URLQueryItem(name: item.key, value: item.value))
            })
            urlComponents.queryItems = requestQueryItems
            return urlComponents.url
        }
    }
}
