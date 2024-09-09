//
//  FavoritesView.swift
//  CryptoPocket
//
//  Created by Mateusz Krówczyński on 09/09/2024.
//

import SwiftUI

struct FavoritesView: View {
    
    @ObservedObject var viewModel = FavoriteViewModel.shared
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Favorites")
                    .font(.title3)
                    .fontWeight(.medium)
                    .foregroundStyle(.textCP)
                
                Spacer()
                
                Button(action: {
                    
                }, label: {
                    HStack {
                        Text("See All")
                        Image(systemName: "list.bullet.clipboard")
                    }
                    .foregroundStyle(.textCP)
                    .font(.subheadline)
                    .underline()
                })
            }
            .padding(.horizontal)
            
            ScrollView(.horizontal) {
                HStack {
                    ForEach(Array(viewModel.favoriteCoins.values)) { coin in
                        FavoriteCoinCell(coin: coin)
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
        .opacity(viewModel.favoriteCoins.isEmpty ? 0 : 1.0)
    }
}

#Preview {
    ZStack {
        Color.backgroundCP.ignoresSafeArea()
        LinearGradient(colors: [Color.backgroundCP, Color.backgroundCP.opacity(0.8), Color.black.opacity(0.3), Color.black.opacity(0.4)], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
        FavoritesView()
    }
}
