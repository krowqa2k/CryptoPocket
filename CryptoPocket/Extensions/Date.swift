//
//  Date.swift
//  CryptoPocket
//
//  Created by Mateusz Krówczyński on 05/09/2024.
//

import Foundation

extension Date {
    
    init(coinGeckString: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = formatter.date(from: coinGeckString) ?? Date()
        self.init(timeInterval: 0, since: date)
    }
    
}
