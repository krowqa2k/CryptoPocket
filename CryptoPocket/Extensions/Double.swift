//
//  Double.swift
//  CryptoPocket
//
//  Created by Mateusz Krówczyński on 08/09/2024.
//

import Foundation

extension Double {
    
    private var currencyFormatter6: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.currencyCode = "usd"
        formatter.currencySymbol = "$"
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 6
        return formatter
    }
    
    private var currencyFormatter2: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.usesGroupingSeparator = true
        formatter.numberStyle = .currency
        formatter.currencyCode = "usd"
        formatter.currencySymbol = "$"
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }
    
    func asCurrencyWith2Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter2.string(from: number) ?? "$0.00"
    }
    
    func asCurrencyWith6Decimals() -> String {
        let number = NSNumber(value: self)
        return currencyFormatter6.string(from: number) ?? "$0.00"
    }
    
       func asNumberString() -> String {
           return String(format: "%.2f", self)
       }
    
    func formattedWithAbbreviations() -> String {
           let num = abs(Double(self))
           let sign = (self < 0) ? "-" : ""

           switch num {
           case 1_000_000_000_000...:
               let formatted = num / 1_000_000_000_000
               let stringFormatted = formatted.asNumberString()
               return "$\(sign)\(stringFormatted)Tr"
           case 1_000_000_000...:
               let formatted = num / 1_000_000_000
               let stringFormatted = formatted.asNumberString()
               return "$\(sign)\(stringFormatted)Bn"
           case 1_000_000...:
               let formatted = num / 1_000_000
               let stringFormatted = formatted.asNumberString()
               return "$\(sign)\(stringFormatted)M"
           case 1_000...:
               let formatted = num / 1_000
               let stringFormatted = formatted.asNumberString()
               return "$\(sign)\(stringFormatted)K"
           case 0...:
               return self.asNumberString()

           default:
               return "\(sign)\(self)"
           }
       }
}
