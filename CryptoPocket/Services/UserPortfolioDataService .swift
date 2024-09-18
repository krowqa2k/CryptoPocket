//
//  UserPortfolioDataService .swift
//  CryptoPocket
//
//  Created by Mateusz Krówczyński on 12/09/2024.
//

import Foundation
import CoreData

final class UserPortfolioDataService {
    
    private let container: NSPersistentContainer
    private let containerName: String = "UserPortfolioContainer"
    private let entityName: String = "PortfolioEntity"
    
    @Published var savedEntities: [PortfolioEntity] = []
    
    init() {
        container = NSPersistentContainer(name: containerName)
        container.loadPersistentStores { (_, error) in
            if let error = error {
                print("Error loading Core Data \(error)")
            }
            self.getPortfolioData()
        }
    }
    
    func updateUserPortfolio(coin: CoinModel, amount: Double) {
        if let entity = savedEntities.first(where: { $0.coinID == coin.id }) {
            if amount > 0 {
                updateAmount(entity: entity, amount: amount)
            } else {
                removeCoin(entity: entity)
            }
        } else {
            add(coin: coin, amount: amount)
        }
    }
    
    func getPortfolioData() {
        let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
        do {
            savedEntities = try container.viewContext.fetch(request)
        } catch let error {
            print("Error fetching data \(error)")
        }
    }
    
    private func add(coin: CoinModel, amount: Double) {
        let entity = PortfolioEntity(context: container.viewContext)
        entity.coinID = coin.id
        entity.symbol = coin.symbol
        entity.name = coin.name
        entity.image = coin.image
        entity.currentPrice = coin.currentPrice
        entity.priceChange24H = coin.priceChange24H
        entity.priceChangePercentage24H = coin.priceChangePercentage24H
        entity.amount = amount
        applyChanges()
    }
    
    private func updateAmount(entity: PortfolioEntity, amount: Double) {
        entity.amount = amount
        applyChanges()
    }
    
    func removeCoin(entity: PortfolioEntity) {
        container.viewContext.delete(entity)
        applyChanges()
    }
    
    private func saveEntity() {
        do {
            try container.viewContext.save()
        } catch let error {
            print("Error saving Core Data \(error)")
        }
    }
    
    private func applyChanges() {
        saveEntity()
        getPortfolioData()
    }
    
    func convertToUserPortfolioModel() -> [UserPortfolioModel] {
        return savedEntities.map { entity in
            UserPortfolioModel(
                id: entity.coinID ?? "",
                symbol: entity.symbol ?? "",
                name: entity.name ?? "",
                image: entity.image ?? "",
                currentPrice: entity.currentPrice,
                priceChange24H: entity.priceChange24H,
                priceChangePercentage24H: entity.priceChangePercentage24H,
                currentHoldings: entity.amount
            )
        }
    }
}
