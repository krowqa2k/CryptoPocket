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
}
