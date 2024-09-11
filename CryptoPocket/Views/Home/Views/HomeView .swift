//
//  HomeView .swift
//  CryptoPocket
//
//  Created by Mateusz Krówczyński on 30/08/2024.
//

import SwiftUI

struct HomeView: View {
    
    @State var index: Int
    @Binding var detailsViewOpened: Bool
    @EnvironmentObject var viewModel: HomeViewModel
    
    var body: some View {
        ZStack {
            background
            
            VStack {
                switch index {
                case 0:
                    defaultView
                case 1:
                    AllCoinsList(detailsViewOpened: $detailsViewOpened)
                default:
                    defaultView
                }
                
                Spacer(minLength: 0)
                if detailsViewOpened == false {
                    TabView(index: $index)
                        .transition(.move(edge: .bottom))
                }
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
    
    private var defaultView: some View {
        NavigationStack {
            ZStack {
                background
                VStack(spacing: 32) {
                    HeaderView()
                    
                    UserBalanceView()
                    
                    FavoritesView()
                    
                    coinList
                }
                .task {
                    await viewModel.fetchCoins()
                }
            }
        }
    }
    
    private var background: some View {
        ZStack {
            Color.backgroundCP.ignoresSafeArea()
            LinearGradient(colors: [Color.backgroundCP, Color.backgroundCP.opacity(0.8), Color.black.opacity(0.3), Color.black.opacity(0.4)], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
        }
    }
    
    private var coinList: some View {
        VStack {
            Text("Most Popular Coins")
                .font(.title2)
                .fontWeight(.medium)
                .fontDesign(.rounded)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .foregroundStyle(.textCP)
            
            ScrollView(.vertical) {
                ForEach(viewModel.coinsData.prefix(15)) { coin in
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
                        HomeCoinListCell(coin: coin)
                    }
                }
            }
            .scrollIndicators(.hidden)
        }
    }
}

#Preview {
    HomeView(index: 0, detailsViewOpened: .constant(false))
        .environmentObject(HomeViewModel())
}

