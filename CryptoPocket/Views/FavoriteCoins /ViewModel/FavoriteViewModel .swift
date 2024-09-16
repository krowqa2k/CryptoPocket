//
//  FavoriteViewModel .swift
//  CryptoPocket
//
//  Created by Mateusz Krówczyński on 09/09/2024.
//

import Foundation

final class FavoriteViewModel: ObservableObject {
    
    static let shared = FavoriteViewModel()
    
    @Published var favoriteCoins: [String: CoinModel] = [:] {
        didSet {
            saveFavorites()
        }
    }
    
    private let userDefaults = UserDefaults.standard
    private let favoritesKey = "FavoriteCoins"
    
    private init() {
        loadFavorites()
    }
    
    func toggleFavorite(coin: CoinModel) {
        if favoriteCoins[coin.id] != nil {
            favoriteCoins.removeValue(forKey: coin.id)
        } else {
            favoriteCoins[coin.id] = coin
        }
    }
    
    func removeAllFavorites() {
        favoriteCoins.removeAll()
    }
    
    func isFavorite(coin: CoinModel) -> Bool {
        return favoriteCoins[coin.id] != nil
    }
    
    private func saveFavorites() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(Array(favoriteCoins.values)) {
            userDefaults.set(encoded, forKey: favoritesKey)
        }
    }
    
    private func loadFavorites() {
        if let savedFavorites = userDefaults.data(forKey: favoritesKey) {
            let decoder = JSONDecoder()
            if let loadedFavorites = try? decoder.decode([CoinModel].self, from: savedFavorites) {
                favoriteCoins = Dictionary(uniqueKeysWithValues: loadedFavorites.map { ($0.id, $0) })
            }
        }
    }
}
