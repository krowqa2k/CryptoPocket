//
//  CoinOverviewView .swift
//  CryptoPocket
//
//  Created by Mateusz Krówczyński on 03/09/2024.
//

import SwiftUI

struct CoinOverviewView: View {
    
    var coin: CoinModel = .mock
    private var priceChange: Color {
        coin.priceChange24H > 0 ? .green : .red
    }
    var body: some View {
        OverviewDetails
        
        AdditionalDetails
    }
}

#Preview {
    CoinOverviewView()
}

extension CoinOverviewView {
    
    private var OverviewDetails: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Overview")
                .font(.title)
                .fontWeight(.medium)
                .foregroundStyle(.textCP)
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Current Price")
                        .font(.caption)
                        .foregroundStyle(.secondaryTextCP)
                    
                    Text("$\(String(format: "%.2f", coin.currentPrice))")
                        .foregroundStyle(.textCP)
                    
                    HStack(spacing: 2) {
                        Image(systemName: "arrow.up")
                        Text("\(String(format: "%.2f", coin.priceChangePercentage24H))%")
                    }
                    .font(.caption)
                    .foregroundStyle(priceChange)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("Market Capitalization")
                        .font(.caption)
                        .foregroundStyle(.secondaryTextCP)
                    
                    Text("$\(String(format: "%.2f", coin.marketCap ?? 0))")
                        .foregroundStyle(.textCP)
                    
                    HStack(spacing: 2) {
                        Image(systemName: "arrow.up")
                        Text("\(String(format: "%.2f", coin.marketCapChangePercentage24H ?? 0))%")
                    }
                    .font(.caption)
                    .foregroundStyle(priceChange)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("Rank")
                        .font(.caption)
                        .foregroundStyle(.secondaryTextCP)
                    
                    Text("\(String(format: "%.0f", coin.marketCapRank ?? 0))")
                        .foregroundStyle(.textCP)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("Volume")
                        .font(.caption)
                        .foregroundStyle(.secondaryTextCP)
                    
                    Text("$\(String(format: "%.2f", coin.totalVolume))")
                        .foregroundStyle(.textCP)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(.horizontal)
        .padding(.bottom, 32)
    }
    
    private var AdditionalDetails: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Additional Details")
                .font(.title)
                .fontWeight(.medium)
                .foregroundStyle(.textCP)
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("24h High")
                        .font(.caption)
                        .foregroundStyle(.secondaryTextCP)
                    
                    Text("$\(String(format: "%.2f", coin.high24H))")
                        .foregroundStyle(.textCP)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("24h Low")
                        .font(.caption)
                        .foregroundStyle(.secondaryTextCP)
                    
                    Text("$\(String(format: "%.2f", coin.low24H))")
                        .foregroundStyle(.textCP)
                    
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("24h Price Change")
                        .font(.caption)
                        .foregroundStyle(.secondaryTextCP)
                    
                    Text("$\(String(format: "%.2f", coin.priceChange24H))")
                        .foregroundStyle(.textCP)
                    
                    HStack(spacing: 2) {
                        Image(systemName: "arrow.up")
                        Text("\(String(format: "%.2f", coin.priceChangePercentage24H))%")
                    }
                    .font(.caption)
                    .foregroundStyle(priceChange)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                
                VStack(alignment: .leading, spacing: 2) {
                    Text("24h Market Cap Change")
                        .font(.caption)
                        .foregroundStyle(.secondaryTextCP)
                    
                    Text("$\(String(format: "%.2f", coin.marketCapChange24H ?? 0))")
                        .foregroundStyle(.textCP)
                    
                    HStack(spacing: 2) {
                        Image(systemName: "arrow.up")
                        Text("\(String(format: "%.2f", coin.marketCapChangePercentage24H ?? 0))%")
                    }
                    .font(.caption)
                    .foregroundStyle(priceChange)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(.horizontal)
    }
}
