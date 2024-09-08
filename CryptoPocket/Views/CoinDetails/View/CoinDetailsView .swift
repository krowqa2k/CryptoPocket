//
//  CoinDetailsView .swift
//  CryptoPocket
//
//  Created by Mateusz Krówczyński on 06/09/2024.
//

import SwiftUI

struct CoinDetailsView: View {
    
    @StateObject var viewModel: DetailViewModel
    @State private var isFavorite: Bool = false
    @State var detailsViewOpened: Bool = true
    @Environment(\.dismiss) var dismiss
    
    init(coin: CoinModel) {
        _viewModel = StateObject(wrappedValue: DetailViewModel(coin: coin))
    }
    
    var body: some View {
        ZStack {
            background
            
            ScrollView(.vertical) {
                VStack(spacing: 20) {
                    LineChartView(coin: viewModel.coin)
                        .padding(.horizontal)
                    
                    Divider()
                        .overlay(Color.secondaryTextCP)
                    
                    CoinOverviewView(coin: viewModel.coin)
                }
                .padding(.top, 20)
            }
            .scrollIndicators(.hidden)
        }
        .navigationTitle(viewModel.coin.name)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                toolbarLeading
            }
        }
    }
    
    private var background: some View {
        NavigationStack {
            ZStack {
                Color.backgroundCP.ignoresSafeArea()
                LinearGradient(colors: [Color.backgroundCP, Color.backgroundCP.opacity(0.8), Color.black.opacity(0.3), Color.black.opacity(0.4)], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
            }
        }
    }
    
    private var toolbarLeading: some View {
        HStack(spacing: 4) {
            Text(viewModel.coin.symbol.uppercased())
            ImageLoader(imageURL: viewModel.coin.image)
                .frame(width: 20, height: 20)
            Button(action: {
                isFavorite.toggle()
            }, label: {
                Image(systemName: "heart.fill")
                    .foregroundStyle(isFavorite ? .red : .secondaryTextCP)
            })
        }
    }
}

#Preview {
    NavigationStack {
        CoinDetailsView(coin: .mock)
    }
}
