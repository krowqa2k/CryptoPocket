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
    @State private var showBottomSheet: Bool = false
    let columns = Array(repeating: GridItem(.flexible()), count: 4)
    
    var body: some View {
        VStack {
            VStack {
                VStack(spacing: 24) {
                    HStack {
                        Text("Add Coin To Portfolio")
                            .font(.title)
                            .foregroundStyle(.textCP)
                        
                        Spacer(minLength: 0)
                        
                        dismissButton
                    }
                    
                    searchBar
                }
                .padding()
                
                ScrollView(.vertical) {
                    coinAddPortfolio
                }
            }
            .background(Color.backgroundCP.ignoresSafeArea())
            
            if showBottomSheet {
                bottomSheet
                    .transition(.move(edge: .bottom))
                    .animation(.easeInOut, value: showBottomSheet)
            }
        }
        .background(Color.backgroundCP.ignoresSafeArea())
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
                        showBottomSheet = false
                        Task {
                            await viewModel.fetchCoinsAndUpdatePortfolio()
                        }
                    }
            }
        }

    }
    
    private var coinAddPortfolio: some View {
        LazyVGrid(columns: columns) {
            ForEach(viewModel.coinsData) { coin in
                AddCoinCell(coin: coin)
                    .onTapGesture {
                        withAnimation(.easeIn) {
                            selectedCoin = coin
                            showBottomSheet = true
                        }
                    }
                    .background(RoundedRectangle(cornerRadius: 10).stroke(selectedCoin?.id == coin.id ? Color.white : Color.clear, lineWidth: 2))
            }
        }
    }
    
    private var bottomSheet: some View {
        VStack(spacing: 20) {
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
                            .onChange(of: amountText, { oldValue, newValue in
                                amountText = newValue.replacingOccurrences(of: ",", with: ".")
                            })
                    }
                    
                    HStack {
                        Text("Current value")
                        Spacer()
                        Text(getCurrentValue().asCurrencyWith6Decimals())
                    }
                }
                .padding()
                .background(Color.backgroundCP)
                .cornerRadius(12)
                .font(.headline)
                .foregroundColor(.textCP)
                
                Button(action: {
                    if let selectedCoin = selectedCoin, let amount = Double(amountText), amount > 0 {
                        viewModel.updateUserPortfolio(coin: selectedCoin, amount: amount)
                        amountText = ""
                        searchCoin = ""
                    }
                    selectedCoin = nil
                    showBottomSheet = false
                }, label: {
                    Text("Save")
                        .font(.title2)
                        .fontWeight(.medium)
                        .foregroundStyle(.textCP)
                        .frame(maxWidth: .infinity)
                        .frame(height: 55)
                        .background(Color.green)
                        .cornerRadius(12)
                })
            }
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.backgroundCP.ignoresSafeArea())
        .cornerRadius(20)
        .shadow(radius: 20)
        .animation(.easeInOut(duration: 0.1), value: showBottomSheet)
    }
}

#Preview {
    AddCoinView()
        .environmentObject(HomeViewModel())
}
