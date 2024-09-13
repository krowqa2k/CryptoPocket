//
//  PortfolioListCell .swift
//  CryptoPocket
//
//  Created by Mateusz Krówczyński on 13/09/2024.
//

import SwiftUI

struct PortfolioListCell_: View {
    
    var portfolioCoin: UserPortfolioModel = .mockPortfolio
    
    var body: some View {
        HStack {
            ImageLoader(imageURL: portfolioCoin.image)
                .frame(width: 40, height: 40)
            
            Text(portfolioCoin.symbol.uppercased())
                .font(.largeTitle)
                .fontWeight(.medium)
                .foregroundStyle(.textCP)
            
            Spacer()
            
            HStack {
                Text(portfolioCoin.currentHoldingsValue.asCurrencyWith2Decimals())
                    .font(.headline)
                    .foregroundStyle(.textCP)
                
                if portfolioCoin.priceChangePercentage24H > 0 {
                    Text("+\(portfolioCoin.priceChangePercentage24H.asNumberString())%")
                        .font(.headline)
                        .foregroundStyle(.green)
                } else {
                    Text("\(portfolioCoin.priceChangePercentage24H.asNumberString())%")
                        .font(.headline)
                        .foregroundStyle(.red)
                }
            }
        }
        .padding(8)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.secondaryTextCP.opacity(0.2))
                
        )
    }
}

#Preview {
    ZStack {
        Color.backgroundCP.ignoresSafeArea()
        PortfolioListCell_()
    }
}
