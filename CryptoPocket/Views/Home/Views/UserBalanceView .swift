//
//  UserBalanceView .swift
//  CryptoPocket
//
//  Created by Mateusz Krówczyński on 30/08/2024.
//

import SwiftUI

struct UserBalanceView: View {
    @EnvironmentObject var viewModel: HomeViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 24) {
                HStack {
                    Text("Your Balance")
                        .font(.system(size: 18))
                        .fontWeight(.medium)
                        .foregroundStyle(.secondaryTextCP)
                    
                    Text("\(viewModel.portfolioChange24h.asNumberString())%")
                        .font(.callout)
                        .foregroundStyle(.black)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .foregroundStyle(viewModel.portfolioChange24h >= 0 ? .green : .red)
                        )
                        .opacity(viewModel.totalUserHoldings.isZero ? 0 : 1)
                    
                    NavigationLink(destination: {
                        UserPortfolioView()
                            .environmentObject(HomeViewModel())
                    }, label: {
                        HStack(spacing: 2) {
                            Text("See")
                            Image(systemName: "person.crop.circle")
                                .font(.headline)
                        }
                    })
                    .foregroundStyle(.textCP)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                    .opacity(viewModel.totalUserHoldings.isZero ? 0 : 1)
                }
                
                Text(viewModel.totalUserHoldings.asCurrencyWith2Decimals())
                    .font(.system(size: 45))
                    .fontWeight(.medium)
                    .foregroundStyle(.textCP)
                    .fontDesign(.rounded)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .foregroundStyle(.ultraThinMaterial.opacity(0.5))
            )
        }
        .padding(.horizontal)
    }
}
