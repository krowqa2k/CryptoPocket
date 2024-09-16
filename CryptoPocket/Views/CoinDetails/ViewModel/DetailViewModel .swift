//
//  DetailViewModel .swift
//  CryptoPocket
//
//  Created by Mateusz Krówczyński on 03/09/2024.
//

import Foundation
import SwiftUI

final class DetailViewModel: ObservableObject {
    @Published var coin: CoinModel
    @Published var isFavorite: Bool = false
    
    var favoritesData = FavoriteViewModel.shared
    
    init(coin: CoinModel) {
        self.coin = coin
        updateFavoriteStatus()
    }
    
    func toggleFavorite() {
        favoritesData.toggleFavorite(coin: coin)
        updateFavoriteStatus()
    }
    
    func updateFavoriteStatus() {
        isFavorite = favoritesData.isFavorite(coin: coin)
    }
}
