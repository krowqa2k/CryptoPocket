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
    @Published var portfolioChange24h: Double = 0

    init() {
        Task {
            await fetchCoinsAndUpdatePortfolio()
        }
    }
    
    var totalUserHoldings: Double {
        userHoldings.reduce(0) { $0 + $1.currentHoldingsValue }
    }

    private let coinDataManager = CoinService()
    private let userPortfolioDataManager = UserPortfolioDataService()

    func fetchCoinsAndUpdatePortfolio() async {
        isLoading = true
        do {
            let coinData = try await coinDataManager.getCoinData()
            self.coinsData = coinData
            updatePortfolio(with: coinData)
        } catch {
            print("Failed to fetch coins \(error)")
        }
        isLoading = false
    }

    private func updatePortfolio(with coins: [CoinModel]) {
        let savedPortfolio = userPortfolioDataManager.convertToUserPortfolioModel()
        
        userHoldings = savedPortfolio.compactMap { holding in
            guard let updatedCoin = coins.first(where: { $0.id == holding.id }) else { return nil }
            
            return UserPortfolioModel(
                id: holding.id,
                symbol: holding.symbol,
                name: holding.name,
                image: holding.image,
                currentPrice: updatedCoin.currentPrice,
                priceChange24H: updatedCoin.priceChange24H,
                priceChangePercentage24H: updatedCoin.priceChangePercentage24H,
                currentHoldings: holding.currentHoldings
            )
        }
        
        calculatePortfolioChange()
    }

    private func calculatePortfolioChange() {
        let previousValue = userHoldings.reduce(0) { $0 + ($1.currentHoldings ?? 0) * ($1.currentPrice - $1.priceChange24H) }
        let currentValue = totalUserHoldings
        if previousValue != 0 {
            portfolioChange24h = ((currentValue - previousValue) / previousValue) * 100
        } else {
            portfolioChange24h = 0
        }
    }

    func updateUserPortfolio(coin: CoinModel, amount: Double) {
        userPortfolioDataManager.updateUserPortfolio(coin: coin, amount: amount)
        Task {
            await fetchCoinsAndUpdatePortfolio()
            fetchPortfolioFromUserData()
        }
    }
    
    func removeCoin(coin: UserPortfolioModel) {
        if let entity = userPortfolioDataManager.savedEntities.first(where: { $0.coinID == coin.id }) {
            userPortfolioDataManager.removeCoin(entity: entity)
        }
        Task {
            await fetchCoinsAndUpdatePortfolio()
            fetchPortfolioFromUserData()
        }
    }

    func filterCoin(search: String) {
        if !search.isEmpty {
            self.coinsData = coinsData.filter {
                $0.name.lowercased().contains(search.lowercased()) ||
                $0.symbol.lowercased().contains(search.lowercased())
            }
        } else {
            Task {
                await fetchCoinsAndUpdatePortfolio()
            }
        }
    }

    func fetchPortfolioFromUserData() {
        let savedPortfolio = userPortfolioDataManager.convertToUserPortfolioModel()
        userHoldings = savedPortfolio.compactMap { holding in
            guard let updatedCoin = coinsData.first(where: { $0.id == holding.id }) else { return nil }
            
            return UserPortfolioModel(
                id: holding.id,
                symbol: holding.symbol,
                name: holding.name,
                image: holding.image,
                currentPrice: updatedCoin.currentPrice,
                priceChange24H: updatedCoin.priceChange24H,
                priceChangePercentage24H: updatedCoin.priceChangePercentage24H,
                currentHoldings: holding.currentHoldings
            )
        }
        calculatePortfolioChange()
        objectWillChange.send()
    }
}
