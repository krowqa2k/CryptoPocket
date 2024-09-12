//
//  UserBalanceView .swift
//  CryptoPocket
//
//  Created by Mateusz Krówczyński on 30/08/2024.
//

import SwiftUI

struct UserBalanceView: View {
    
    @State private var isProfit: Bool = true
    @EnvironmentObject var viewModel: HomeViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 24) {
                HStack {
                    Text("Your Balance")
                        .font(.system(size: 18))
                        .fontWeight(.medium)
                        .foregroundStyle(.secondaryTextCP)
                    
                    Text("+37,2%")
                        .font(.callout)
                        .foregroundStyle(.black)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .foregroundStyle(isProfit ? .green : .red)
                        )
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
        .task {
            viewModel.fetchPortfolioFromUserData()
        }
    }
}

#Preview {
    ZStack {
        Color.backgroundCP.ignoresSafeArea()
        UserBalanceView()
            .environmentObject(HomeViewModel())
    }
}
