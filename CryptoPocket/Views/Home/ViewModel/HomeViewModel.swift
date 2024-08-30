//
//  HomeViewModel.swift
//  CryptoPocket
//
//  Created by Mateusz Krówczyński on 30/08/2024.
//

import Foundation

@MainActor
final class HomeViewModel: ObservableObject {
    
    @Published private(set) var allCoins: [CoinModel] = []
    @Published var isLoading: Bool = false
    
    let coinDataManager = CoinService()
    
    func fetchCoins() async {
        isLoading = true
        
        do {
            let coinData = try await coinDataManager.getCoinData()
            
            let decodedCoins = try JSONDecoder().decode([CoinModel].self, from: coinData)
            
            self.allCoins = decodedCoins
        } catch {
            print("Failed to fetch coins \(error)")
        }
        
        isLoading = false
    }
}
