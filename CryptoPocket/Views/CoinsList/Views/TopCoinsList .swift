//
//  TopCoinsList .swift
//  CryptoPocket
//
//  Created by Mateusz Krówczyński on 01/09/2024.
//

import SwiftUI

struct AllCoinsList: View {
    
    @ObservedObject private var viewModel = CoinsViewModel()
    @State private var buttonIndex: Int = 0
    @State var searchCoin: String = ""
    @Binding var detailsViewOpened: Bool
    @State private var refreshTapped: Bool = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.backgroundCP.ignoresSafeArea()
                VStack(alignment: .leading, spacing: 4) {
                    Text("All Coins")
                        .font(.title3)
                        .foregroundStyle(.textCP)
                        .fontWeight(.medium)
                    
                    Divider()
                        .background(Color.secondaryTextCP.opacity(0.5))
                        .padding(.top, 8)
                    
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .font(.title2)
                            .foregroundStyle(.textCP)
                            .padding(.leading, 2)
                            .padding(.top, 2)
                        
                        TextField("Search coin...", text: $searchCoin) {
                            viewModel.filterCoins(search: searchCoin)
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
                                    Task {
                                        await viewModel.fetchCoins()
                                    }
                                }
                        }
                    }
                    
                    filterButtons
                    
                    ScrollView(.vertical) {
                        ForEach(viewModel.allCoins) { coin in
                            NavigationLink(destination: CoinDetailsView(coin: coin)
                                .onAppear(perform: {
                                    withAnimation(.linear(duration: 0.2)) {
                                        detailsViewOpened = true
                                    }
                                })
                                .onDisappear(perform: {
                                    withAnimation(.linear(duration: 0.1)) {
                                        detailsViewOpened = false
                                    }
                                })) {
                                CoinListCell(coin: coin)
                                    .padding(.top)
                            }
                        }
                    }
                    .scrollIndicators(.hidden)
                }
                .padding(.horizontal)
            }
            .task {
                await viewModel.fetchCoins()
        }
        }
    }
    
    private var filterButtons: some View {
        HStack {
            Button(action: {
                self.buttonIndex = 0
                viewModel.sortCoins(by: .marketCap)
            }, label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .frame(width: 60, height: 20)
                        .foregroundStyle(.secondaryTextCP.opacity(self.buttonIndex == 0 ? 0.5 : 0.0))
                    Text("Coin")
                        .foregroundStyle(self.buttonIndex == 0 ? .textCP : .secondaryTextCP)
                }
            })
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Button(action: {
                self.buttonIndex = 1
                viewModel.sortCoins(by: .priceChange)
            }, label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .frame(width: 120, height: 20)
                        .foregroundStyle(.secondaryTextCP.opacity(self.buttonIndex == 1 ? 0.5 : 0.0))
                    Text("Price Change 24h")
                        .foregroundStyle(self.buttonIndex == 1 ? .textCP : .secondaryTextCP)
                }
            })
            .offset(x: 30)
            .frame(maxWidth: .infinity)
            
            Button(action: {
                self.buttonIndex = 2
                viewModel.sortCoins(by: .price)
            }, label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 12)
                        .frame(width: 60, height: 20)
                        .foregroundStyle(.secondaryTextCP.opacity(self.buttonIndex == 2 ? 0.5 : 0.0))
                    Text("Price")
                        .foregroundStyle(self.buttonIndex == 2 ? .textCP : .secondaryTextCP)
                }
            })
            .frame(maxWidth: .infinity)
            
            Button(action: {
                Task {
                    await viewModel.fetchCoins()
                }
                refreshTapped.toggle()
                buttonIndex = 0
            }, label: {
                withAnimation {
                    Image(systemName: "arrow.uturn.forward")
                        .font(.system(size: 15))
                        .foregroundStyle(.secondaryTextCP)
                        .rotationEffect(.degrees(refreshTapped ? 360 : 0))
                        .animation(.smooth(duration: 1), value: refreshTapped)
                }
            })
            .offset(x: 10)
        }
        .padding(.top, 8)
        .padding(.horizontal, 4)
        .font(.caption)
    }
}

#Preview {
    ZStack {
        Color.backgroundCP.ignoresSafeArea()
        AllCoinsList(detailsViewOpened: .constant(false))
    }
}
