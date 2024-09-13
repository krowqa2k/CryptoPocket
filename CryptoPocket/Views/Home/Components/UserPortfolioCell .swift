//
//  UserPortfolioCell .swift
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
            
            Spacer()
            
            HStack {
                Text(portfolioCoin.currentHoldingsValue.asCurrencyWith2Decimals())
            }
        }
        .foregroundStyle(.textCP)
        .padding(12)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.secondaryTextCP.opacity(0.2))
        )
    }
}

#Preview {
    PortfolioListCell_()
}

