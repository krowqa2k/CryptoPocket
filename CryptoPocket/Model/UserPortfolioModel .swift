//
//  UserPortfolioModel .swift
//  CryptoPocket
//
//  Created by Mateusz Krówczyński on 12/09/2024.
//

import Foundation

struct UserPortfolioModel: Identifiable {
    let id, symbol, name: String
    let image: String
    let currentPrice: Double
    let priceChange24H, priceChangePercentage24H: Double
    let currentHoldings: Double?
    
    var currentHoldingsValue: Double {
            (currentHoldings ?? 0) * currentPrice
    }
    
    static var mockPortfolio: UserPortfolioModel {
        UserPortfolioModel(
            id: "bitcoin",
            symbol: "btc",
            name: "Bitcoin",
            image: "https://coin-images.coingecko.com/coins/images/1/large/bitcoin.png?1696501400",
            currentPrice: 60898,
            priceChange24H: 2155.47,
            priceChangePercentage24H: 3.27,
            currentHoldings: 0.11
        )
    }
}
