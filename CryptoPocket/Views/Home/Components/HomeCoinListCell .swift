//
//  HomeCoinListCell .swift
//  CryptoPocket
//
//  Created by Mateusz Krówczyński on 06/09/2024.
//

import SwiftUI

struct HomeCoinListCell: View {
    
    var coin: CoinModel = .mock
    
    var body: some View {
        HStack {
            ImageLoader(imageURL: coin.image)
                .frame(width: 40, height: 40)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(coin.name)
                    .font(.callout)
                    .foregroundStyle(.textCP)
                
                Text(coin.symbol.uppercased())
                    .foregroundStyle(.secondaryTextCP)
                    .font(.system(size: 12))
            }

            Spacer(minLength: 0)
            
            VStack(alignment: .trailing, spacing: 4) {
                Text("$\(String(format: "%.2f", coin.currentPrice))")
                    .font(.callout)
                    .fontWeight(.semibold)
                    .foregroundStyle(.textCP)
                
                if coin.priceChangePercentage24H > 0 {
                    Text("+\(String(format: "%.2f", coin.priceChangePercentage24H))%")
                        .font(.caption)
                        .foregroundStyle(.green)
                } else {
                    Text("\(String(format: "%.2f", coin.priceChangePercentage24H))%")
                        .font(.caption)
                        .foregroundStyle(.red)
                }
            }
        }
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(.ultraThinMaterial.opacity(0.3))
        )
        .padding(.horizontal, 8)
    }
}

#Preview {
    ZStack {
        Color.backgroundCP.ignoresSafeArea()
        LinearGradient(colors: [Color.backgroundCP, Color.backgroundCP.opacity(0.8), Color.black.opacity(0.3), Color.black.opacity(0.4)], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
        ScrollView(.vertical) {
            HomeCoinListCell()
            HomeCoinListCell()
            HomeCoinListCell()
        }
    }
}
