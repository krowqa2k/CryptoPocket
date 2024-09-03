//
//  CoinDetailService.swift
//  CryptoPocket
//
//  Created by Mateusz Krówczyński on 03/09/2024.
//

import Foundation

@MainActor
final class CoinDetailService: ObservableObject {
    
    let coin: CoinModel
    
    init(coin: CoinModel) {
        self.coin = coin
    }
    
    func getCoinDetails() async throws -> [CoinModel] {
        let urlString: String = "https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false"
        
        guard let url = URL(string: urlString) else {
            throw ErrorCases.InvalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            if let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200:
                    let decoder = try JSONDecoder().decode([CoinModel].self, from: data)
                    return decoder
                default:
                    throw ErrorCases.InvalidResponse
                }
            }
        } catch {
            print("Error fetching coin data \(error)")
        }
        
        throw ErrorCases.InvalidData
    }
}
