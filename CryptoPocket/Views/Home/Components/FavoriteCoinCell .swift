//
//  FavoriteCoinCell .swift
//  CryptoPocket
//
//  Created by Mateusz Krówczyński on 03/09/2024.
//

import SwiftUI

struct FavoriteCoinCell: View {
    
    var coin: CoinModel = .mock
    
    var body: some View {
        HStack {
            coinImage
            
            VStack(alignment: .leading, spacing: 6) {
                coinNameSymbol
                
                coinPriceData
            }
        }
        .padding(2)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.backgroundCP)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.secondaryTextCP.opacity(0.5), lineWidth: 2)
        )
        .clipShape(
            RoundedRectangle(cornerRadius: 12)
        )
        .padding(.leading, 12)
    }
    
    private var coinImage: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .frame(width: 60, height: 60)
                .foregroundStyle(.componentsCP.opacity(0.1))
            
            ImageLoader(imageURL: coin.image)
                .frame(width: 40, height: 40)
        }
    }
    
    private var coinNameSymbol: some View {
        HStack(spacing: 2) {
            Text(coin.name)
            Text("(\(coin.symbol.uppercased()))")
        }
        .font(.callout)
        .foregroundStyle(.secondaryTextCP)
    }
    
    private var coinPriceData: some View {
        HStack(spacing: 6) {
            Group {
                Text("$")
                +
                Text(String(format: "%.1f", coin.currentPrice))
            }
            .foregroundStyle(.textCP)
            .fontWeight(.medium)
            .font(.callout)
            
            if coin.priceChangePercentage24H > 0 {
                Group{
                    Text("+")
                    +
                    Text(String(format: "%.2f", coin.priceChangePercentage24H))
                    +
                    Text("%")
                }
                .font(.system(size: 12))
                .foregroundStyle(.green)
            } else {
                Group {
                    Text(String(format: "%.2f", coin.priceChangePercentage24H))
                    +
                    Text("%")
                }
                .font(.system(size: 12))
                .foregroundStyle(.red)
            }
        }
        .padding(.trailing, 6)
    }
}

#Preview {
    ZStack {
        Color.backgroundCP.ignoresSafeArea()
        ScrollView(.horizontal) {
            HStack(spacing: 0) {
                FavoriteCoinCell()
                FavoriteCoinCell()
                FavoriteCoinCell()
                FavoriteCoinCell()
            }
        }
        .scrollIndicators(.hidden)
    }
}
