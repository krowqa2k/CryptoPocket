//
//  TopCoinsList .swift
//  CryptoPocket
//
//  Created by Mateusz Krówczyński on 01/09/2024.
//

import SwiftUI

struct TopCoinsList: View {
    
    @ObservedObject private var viewModel = HomeViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Popular Coins")
                .font(.title3)
                .foregroundStyle(.textCP)
                .fontWeight(.medium)
            
            Divider()
                .background(Color.secondaryTextCP.opacity(0.5))
                .padding(.top, 8)
            
            HStack {
                Text("Coin")
                Spacer()
                Text("Price Change")
                    .offset(x: 30)
                Spacer()
                Text("Price")
            }
            .padding(.top, 8)
            .padding(.horizontal)
            .font(.caption)
            .foregroundStyle(.textCP)
            
            ScrollView(.vertical) {
                ForEach(viewModel.allCoins.prefix(15)) { coin in
                    CoinListCell(coin: coin)
                        .padding(.top)
                }
            }
            .scrollIndicators(.hidden)
        }
        .padding(.horizontal)
        .task {
            await viewModel.fetchCoins()
        }
    }
}

#Preview {
    ZStack {
        Color.backgroundCP.ignoresSafeArea()
        TopCoinsList()
    }
}
