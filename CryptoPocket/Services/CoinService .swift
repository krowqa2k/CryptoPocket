//
//  CoinService .swift
//  CryptoPocket
//
//  Created by Mateusz Krówczyński on 30/08/2024.
//

import Foundation

@MainActor
final class CoinService: ObservableObject {
    func getCoinData() async throws -> Data {
        
        let urlString: String = "https://api.coingecko.com/api/v3/coins/markets"
        
        guard let url = URL(string: urlString) else {
            throw ErrorCases.InvalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            if let response = response as? HTTPURLResponse {
                switch response.statusCode {
                case 200:
                    return data
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
