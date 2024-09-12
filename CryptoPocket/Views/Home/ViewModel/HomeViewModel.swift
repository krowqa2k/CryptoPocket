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
    @Published private(set) var userHoldings: [UserPortfolioModel] = []
    @Published var isLoading: Bool = false
    
    var totalUserHoldings: Double {
        userHoldings.reduce(0) { $0 + $1.currentHoldingsValue }
    }
    
    init() {
        fetchPortfolioFromUserData()
    }
    
    private let coinDataManager = CoinService()
    private let userPortfolioDataManager = UserPortfolioDataService()
    
    func filterCoin(search: String) {
        if !search.isEmpty {
            self.coinsData = coinsData.filter {
                $0.name.lowercased().contains(search.lowercased()) ||
                $0.symbol.lowercased().contains(search.lowercased())
            }
        }
    }
    
    func updateUserPortfolio(coin: CoinModel, amount: Double) {
        userPortfolioDataManager.updateUserPortfolio(coin: coin, amount: amount)
        fetchPortfolioFromUserData()
    }
    
    func fetchPortfolioFromUserData() {
        userHoldings = userPortfolioDataManager.convertToUserPortfolioModel()
    }
    
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
