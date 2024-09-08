//
//  CoinListCell .swift
//  CryptoPocket
//
//  Created by Mateusz Krówczyński on 01/09/2024.
//

import SwiftUI

struct CoinListCell: View {
    
    var coin: CoinModel = .mock
    
    var body: some View {
        HStack(spacing: 4) {
            coinImgNameSym
            
            Spacer(minLength: 0)
            
            coinData
        }
        .frame(height: 40)
    }
    
    private var coinImgNameSym: some View {
        HStack(alignment: .center, spacing: 12) {
            ImageLoader(imageURL: coin.image)
                .frame(width: 40, height: 40)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(coin.name)
                    .font(.callout)
                    .foregroundStyle(.textCP)
                
                Text(coin.symbol.uppercased())
                    .font(.caption)
                    .foregroundStyle(.secondaryTextCP)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    private var coinData: some View {
        HStack(spacing: 24) {
            if coin.priceChangePercentage24H > 0 {
                Group {
                    Text("+")
                    +
                    Text(coin.priceChangePercentage24H.asNumberString())
                    +
                    Text("%")
                }
                .font(.callout)
                .fontWeight(.medium)
                .foregroundStyle(.green)
            } else {
                Group {
                    Text(coin.priceChangePercentage24H.asNumberString())
                    +
                    Text("%")
                }
                .font(.callout)
                .fontWeight(.medium)
                .foregroundStyle(.red)
            }
            Text("$")
                .foregroundStyle(.textCP)
            +
            Text(coin.currentPrice.asNumberString())
                .font(.headline)
                .foregroundStyle(.textCP)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#Preview {
    ZStack {
        Color.backgroundCP.ignoresSafeArea()
        CoinListCell()
    }
}
