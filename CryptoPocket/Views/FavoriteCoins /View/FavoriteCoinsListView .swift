//
//  FavoriteCoinsListView .swift
//  CryptoPocket
//
//  Created by Mateusz Krówczyński on 09/09/2024.
//

import SwiftUI

struct FavoriteCoinsListView: View {
    
    @ObservedObject var viewModel = FavoriteViewModel.shared
    
    var body: some View {
        ZStack {
            Color.backgroundCP.ignoresSafeArea()
            VStack {
                HStack {
                    Text("Favorite Coins")
                        .font(.title)
                        .fontWeight(.medium)
                        .foregroundStyle(.textCP)
                    Spacer()
                    Button(action: {
                        viewModel.removeAllFavorites()
                    }, label: {
                        Text("Remove all")
                            .foregroundStyle(.red)
                    })
                }
                ScrollView(.vertical) {
                    ForEach(Array(viewModel.favoriteCoins.values)) { coin in
                        CoinListCell(coin: coin)
                            .padding(.top)
                    }
                }
            }
            .padding(.horizontal)
        }
    }
}

#Preview {
    NavigationStack {
        FavoriteCoinsListView()
    }
}
