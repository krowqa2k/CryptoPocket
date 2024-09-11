//
//  HomeViewModel.swift
//  CryptoPocket
//
//  Created by Mateusz Krówczyński on 30/08/2024.
//

import Foundation

@MainActor
final class HomeViewModel: ObservableObject {
    
    @Published private(set) var coinsData: [CoinModel] = []
    @Published var isLoading: Bool = false
    
    func filterCoin(search: String) {
        if !search.isEmpty {
            self.coinsData = coinsData.filter {
                $0.name.lowercased().contains(search.lowercased()) ||
                $0.symbol.lowercased().contains(search.lowercased())
            }
        }
    }
    
    let coinDataManager = CoinService()
    
    func fetchCoins() async {
        isLoading = true
        
        do {
            let coinData = try await coinDataManager.getCoinData()
            
            self.coinsData = coinData
            
        } catch {
            print("Failed to fetch coins \(error)")
        }
        
        isLoading = false
    }
}
