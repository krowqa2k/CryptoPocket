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
    
    func filterCoins(search: String) {
        if !search.isEmpty {
            self.allCoins = allCoins.filter {
                $0.name.lowercased().contains(search.lowercased()) ||
                $0.symbol.lowercased().contains(search.lowercased())
            }
        }
    }
    
    enum SortOption {
        case marketCap, priceChange, price
    }
    
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
    
    func sortCoins(by option: SortOption) {
        switch option {
        case .marketCap:
            allCoins.sort { $0.marketCap ?? 0.0 > $1.marketCap ?? 0.0 }
        case .priceChange:
            allCoins.sort { $0.priceChangePercentage24H > $1.priceChangePercentage24H }
        case .price:
            allCoins.sort { $0.currentPrice > $1.currentPrice }
        }
    }
}
