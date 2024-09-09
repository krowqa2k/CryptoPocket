//
//  FavoriteViewModel .swift
//  CryptoPocket
//
//  Created by Mateusz Krówczyński on 09/09/2024.
//

import Foundation

final class FavoriteViewModel: ObservableObject {
    
    static let shared = FavoriteViewModel()
    private init() {}
    
    @Published var favoriteCoins: [String: CoinModel] = [:]
    
    func toggleFavorite(coin: CoinModel) {
        if favoriteCoins[coin.id] != nil {
            favoriteCoins.removeValue(forKey: coin.id)
        } else {
            favoriteCoins[coin.id] = coin
        }
    }
    
    func isFavorite(coin: CoinModel) -> Bool {
        return favoriteCoins[coin.id] != nil
    }
    
}
