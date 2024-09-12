//
//  AddCoinView.swift
//  CryptoPocket
//
//  Created by Mateusz Krówczyński on 11/09/2024.
//

import SwiftUI

struct AddCoinView: View {
    
    @EnvironmentObject var viewModel: HomeViewModel
    @Environment(\.dismiss) var dismiss
    @State private var selectedCoin: CoinModel? = nil
    @State private var amountText: String = ""
    @State private var searchCoin: String = ""
    
    var body: some View {
        ZStack {
            Color.backgroundCP.ignoresSafeArea()
            
            VStack(spacing: 24) {
                HStack {
                    Text("Add Coin To Portfolio")
                        .font(.title)
                        .foregroundStyle(.textCP)
                    
                    Spacer(minLength: 0)
                    
                    dismissButton
                }
                
                searchBar
                
                coinAddPortfolio
                
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
        }
        .task {
            await viewModel.fetchCoins()
        }
    }
    
    private var dismissButton: some View {
        Button(action: {
            dismiss()
        }, label: {
            ZStack {
                Circle()
                    .frame(width: 40, height: 40)
                    .foregroundStyle(.secondaryTextCP.opacity(0.5))
                
                Image(systemName: "xmark")
                    .foregroundStyle(.white)
                    .fontWeight(.semibold)
            }
        })
    }
    
    private func getCurrentValue() -> Double {
        if let amount = Double(amountText) {
            return amount * (selectedCoin?.currentPrice ?? 0)
        }
        return 0
    }
    
    private var searchBar: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .font(.title2)
                .foregroundStyle(.textCP)
                .padding(.leading, 2)
                .padding(.top, 2)
            
            TextField("Search coin...", text: $searchCoin) {
                viewModel.filterCoin(search: searchCoin)
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .tint(.backgroundCP)
            .autocorrectionDisabled()
            .textInputAutocapitalization(.never)
            
            if !searchCoin.isEmpty {
                Image(systemName: "xmark.circle.fill")
                    .padding(.horizontal, 8)
                    .foregroundStyle(.textCP)
                    .background(Color.black.opacity(0.001))
                    .onTapGesture {
                        searchCoin = ""
                        selectedCoin = nil
                        Task {
                            await viewModel.fetchCoins()
                        }
                    }
            }
        }

    }
    
    private var coinAddPortfolio: some View {
        VStack(spacing: 12) {
            ScrollView(.horizontal) {
                HStack(spacing: 12) {
                    ForEach(viewModel.coinsData){ coin in
                        AddCoinCell(coin: coin)
                            .onTapGesture {
                                withAnimation(.easeIn) {
                                    selectedCoin = coin
                                }
                            }
                            .background(RoundedRectangle(cornerRadius: 10).stroke(selectedCoin?.id == coin.id ? Color.white : Color.clear, lineWidth: 2))
                    }
                }
            }
            .scrollIndicators(.hidden)
            
            if selectedCoin != nil {
                VStack(spacing: 20) {
                    HStack {
                        Text("Current price of \(selectedCoin?.symbol.uppercased() ?? ""):")
                        Spacer()
                        Text(selectedCoin?.currentPrice.asCurrencyWith6Decimals() ?? "")
                    }
                    
                    HStack {
                        Text("Amount:")
                        Spacer()
                        TextField("Ex: 2.4", text: $amountText)
                            .multilineTextAlignment(.trailing)
                            .keyboardType(.decimalPad)
                    }
                    
                    HStack {
                        Text("Current value")
                        Spacer()
                        Text(getCurrentValue().asCurrencyWith6Decimals())
                    }
                }
                .padding()
                .font(.headline)
                .foregroundColor(.textCP)
            }
            Spacer()
            if !amountText.isEmpty {
                withAnimation(.easeInOut) {
                    Button(action: {
                        if let selectedCoin = selectedCoin, let amount = Double(amountText), amount > 0 {
                                viewModel.updateUserPortfolio(coin: selectedCoin, amount: amount)
                                amountText = ""
                                searchCoin = ""
                            }
                        selectedCoin = nil
                    }, label: {
                        Text("Save")
                            .font(.title2)
                            .fontWeight(.medium)
                            .foregroundStyle(.textCP)
                            .frame(maxWidth: .infinity)
                            .frame(height: 55)
                            .background(
                                Color.green
                            )
                            .cornerRadius(12)
                    })
                }
            }
                
            Spacer()
        }
    }
}

#Preview {
    AddCoinView()
        .environmentObject(HomeViewModel())
}
