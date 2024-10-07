//
//  AddCoinCell .swift
//  CryptoPocket
//
//  Created by Mateusz Krówczyński on 11/09/2024.
//

import SwiftUI

struct AddCoinCell: View {
    
    var coin: CoinModel = .mock
    
    var body: some View {
        VStack(alignment: .center, spacing: 6) {
            ImageLoader(imageURL: coin.image)
                .frame(width: 50, height: 50)
            
            VStack(alignment: .center, spacing: 0){
                Text(coin.symbol.uppercased())
                    .font(.title3)
                    .foregroundStyle(.textCP)
                    .fontWeight(.medium)
                Text(coin.name)
                    .font(.footnote)
                    .foregroundStyle(.secondaryTextCP)
            }
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 4)
    }
}

#Preview {
    ZStack {
        Color.backgroundCP.ignoresSafeArea()
        ScrollView(.horizontal) {
            HStack(spacing: 12) {
                AddCoinCell()
                AddCoinCell()
                AddCoinCell()
                AddCoinCell()
            }
        }
        .scrollIndicators(.hidden)
        .padding(.leading)
    }
}
