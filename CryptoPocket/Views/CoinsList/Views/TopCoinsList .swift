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
    @Namespace private var namespace
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.backgroundCP.ignoresSafeArea()
                LinearGradient(colors: [Color.backgroundCP, Color.backgroundCP.opacity(0.8), Color.black.opacity(0.3), Color.black.opacity(0.4)], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
                
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
                withAnimation(.spring()) {
                    self.buttonIndex = 0
                    viewModel.sortCoins(by: .marketCap)
                }
            }, label: {
                Text("Coin")
                    .foregroundStyle(self.buttonIndex == 0 ? .textCP : .secondaryTextCP)
                    .font(.system(size: 10))
            })
            .background(
                ZStack {
                    if self.buttonIndex == 0 {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.secondaryTextCP.opacity(0.5))
                            .matchedGeometryEffect(id: "background", in: namespace)
                            .frame(width: 60, height: 20)
                    }
                }
            )
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Button(action: {
                withAnimation(.spring()) {
                    self.buttonIndex = 1
                    viewModel.sortCoins(by: .priceChange)
                }
            }, label: {
                Text("Price-24h")
                    .foregroundStyle(self.buttonIndex == 1 ? .textCP : .secondaryTextCP)
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 10))
            })
            .background(
                ZStack {
                    if self.buttonIndex == 1 {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.secondaryTextCP.opacity(0.5))
                            .matchedGeometryEffect(id: "background", in: namespace)
                            .frame(width: 60, height: 20)
                    }
                }
            )
            .offset(x: 50)
            
            Button(action: {
                withAnimation(.spring()) {
                    self.buttonIndex = 2
                    viewModel.sortCoins(by: .price)
                }
            }, label: {
                Text("Price")
                    .foregroundStyle(self.buttonIndex == 2 ? .textCP : .secondaryTextCP)
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 10))
            })
            .background(
                ZStack {
                    if self.buttonIndex == 2 {
                        RoundedRectangle(cornerRadius: 12)
                            .fill(Color.secondaryTextCP.opacity(0.5))
                            .matchedGeometryEffect(id: "background", in: namespace)
                            .frame(width: 60, height: 20)
                    }
                }
            )
            .offset(x: 20)
            
            if #available(iOS 18.0, *) {
                Image(systemName: "bitcoinsign.arrow.trianglehead.counterclockwise.rotate.90")
                    .font(.title3)
                    .foregroundStyle(.green)
                    .onTapGesture {
                        refreshTapped.toggle()
                        Task {
                            await viewModel.fetchCoins()
                        }
                        buttonIndex = 0
                    }
                    .symbolEffect(.rotate, value: refreshTapped)
                    .offset(x: 10)
                
            } else {
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
            
        }
        .padding(.top, 8)
        .padding(.horizontal, 16)
        .font(.caption)
    }
}


#Preview {
    ZStack {
        Color.backgroundCP.ignoresSafeArea()
        AllCoinsList(detailsViewOpened: .constant(false))
    }
}
