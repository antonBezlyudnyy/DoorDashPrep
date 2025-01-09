//
//  CarouselView.swift
//  DoorDashPrep
//
//  Created by Anton Bezlyudnyy on 11/2/24.
//

import SwiftUI

struct CarouselView: View {
    private let imageURLs: [String]!
    @State private var currentIndex: Int = 0
    
    init(imageURLs: [String]!) {
        self.imageURLs = imageURLs
    }
    
    var body: some View {
        TabView(selection: $currentIndex) {
            ForEach(imageURLs.indices, id: \.self) { index in
                if let imageURL = URL(string: imageURLs[index]) {
                    AsyncImage(url: imageURL) { image in
                        image
                            .resizable()
                            .scaledToFit()
                            .clipped()
                    } placeholder: {
                        ProgressView()
                            .progressViewStyle(.circular)
                    }
                }
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .automatic))
        .indexViewStyle(.page(backgroundDisplayMode: .always))
        .frame(height: 200)
    }
}

#Preview {
    CarouselView(imageURLs: ["", ""])
}
