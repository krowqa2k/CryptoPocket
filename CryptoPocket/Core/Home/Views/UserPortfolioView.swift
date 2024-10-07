//
//  UserPortfolioView.swift
//  CryptoPocket
//
//  Created by Mateusz Krówczyński on 13/09/2024.
//

import SwiftUI

struct UserPortfolioView: View {
    @EnvironmentObject var viewModel: HomeViewModel
    @State private var isRemovePressed: Bool = false
    
    var body: some View {
        ZStack {
            Color.backgroundCP.ignoresSafeArea()
            VStack(spacing: 34) {
                HStack {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("Portfolio Balance")
                                .font(.system(size: 18))
                                .fontWeight(.medium)
                                .foregroundStyle(.secondaryTextCP)
                            
                            Spacer()
                            
                            Button {
                                isRemovePressed.toggle()
                            } label: {
                                HStack(spacing: 4) {
                                    Text("Edit")
                                    Image(systemName: isRemovePressed ? "checkmark.circle.fill" : "pencil.circle.fill")
                                }
                                .foregroundStyle(.red)
                            }
                        }
                        
                        HStack(spacing: 20) {
                            Text(viewModel.totalUserHoldings.asCurrencyWith2Decimals())
                                .font(.system(size: 40))
                                .fontWeight(.medium)
                                .foregroundStyle(.textCP)
                                .fontDesign(.rounded)
                        
                            Text("\(viewModel.portfolioChange24h.asNumberString())% last 24H")
                                .font(.subheadline)
                                .foregroundStyle(viewModel.portfolioChange24h >= 0 ? .green : .red)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .foregroundStyle(.ultraThinMaterial.opacity(0.5))
                )
                .padding(.horizontal)
                
                VStack {
                    HStack(spacing: 60) {
                        Text("Coin")
                        Spacer()
                        Text("Holdings")
                        Text("Live Price")
                    }
                    .font(.caption)
                    .foregroundStyle(.secondaryTextCP)
                    .padding(.horizontal, 30)
                    ForEach(viewModel.userHoldings) { coin in
                        PortfolioListCell_(portfolioCoin: coin)
                            .padding(.horizontal)
                            .overlay(
                                withAnimation(.easeIn, {
                                    Button(action: {
                                        viewModel.removeCoin(coin: coin)
                                    }, label: {
                                        ZStack {
                                            Circle()
                                                .frame(width: 25, height: 25)
                                                .foregroundStyle(.red)
                                            Image(systemName: "xmark")
                                                .font(.headline)
                                                .foregroundStyle(.textCP)
                                        }
                                        .animation(.easeIn, value: isRemovePressed)
                                    }).offset(x: -20).opacity(isRemovePressed ? 1 : 0)
                                })
                                ,alignment: .center)
                    }
                }
                
                Spacer()
            }
        }
        .task {
            viewModel.fetchPortfolioFromUserData()
        }
    }
}

#Preview {
    UserPortfolioView()
        .environmentObject(HomeViewModel())
}
