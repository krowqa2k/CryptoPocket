//
//  ImageLoader.swift
//  CryptoPocket
//
//  Created by Mateusz Krówczyński on 01/09/2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct ImageLoader: View {
    
    var imageURL: String = Constants.mockImage
    
    var body: some View {
        Rectangle()
            .opacity(0.001)
            .overlay {
                WebImage(url: URL(string: imageURL))
                    .resizable()
                    .indicator(.activity)
                    .allowsHitTesting(false)
            }
            .clipped()
    }
}

#Preview {
    ImageLoader()
}
