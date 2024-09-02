//
//  CoinsViewModel.swift
//  CryptoPocket
//
//  Created by Mateusz Krówczyński on 02/09/2024.
//

import Foundation

@MainActor
final class CoinsViewModel: ObservableObject {
    
    @Published private(set) var allCoins: [CoinModel] = []
    @Published var isLoading: Bool = false
    
    let coinDataManager = CoinService()
    
    func fetchCoins() async {
        isLoading = true
        
        do {
            let coinData = try await coinDataManager.getCoinData()
            
            self.allCoins = coinData
            
        } catch {
            print("Failed to fetch coins \(error)")
        }
        
        isLoading = false
    }
}
