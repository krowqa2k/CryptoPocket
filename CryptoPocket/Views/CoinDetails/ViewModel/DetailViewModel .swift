//
//  DetailViewModel .swift
//  CryptoPocket
//
//  Created by Mateusz Krówczyński on 03/09/2024.
//

import Foundation

final class DetailViewModel: ObservableObject {
    @Published var coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
    }
}
