//
//  DetailViewModel .swift
//  CryptoPocket
//
//  Created by Mateusz Krówczyński on 03/09/2024.
//

import Foundation

@MainActor
final class DetailViewModel: ObservableObject {
    @Published var overviewStatistics: [CoinModel] = []
    @Published var coin: CoinModel
    
    private let coinDetailService: CoinDetailService
    
    init(coin: CoinModel) {
        self.coin = coin
        self.coinDetailService = CoinDetailService(coin: coin)
    }
    
    func getStatistics() async {
        do {
            let coinData = try await coinDetailService.getCoinDetails()
            
            self.overviewStatistics = coinData
        } catch {
            print("Error fetching statistics \(error)")
        }
    }
}
