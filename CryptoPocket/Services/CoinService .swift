//
//  CoinService .swift
//  CryptoPocket
//
//  Created by Mateusz Krówczyński on 30/08/2024.
//

import Foundation

@MainActor
final class CoinService: ObservableObject {
    func getCoinData() async throws -> [CoinModel] {
        
        let urlString: String = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h"
        
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
