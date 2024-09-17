//
//  headerView.swift
//  CryptoPocket
//
//  Created by Mateusz Krówczyński on 30/08/2024.
//

import SwiftUI

struct HeaderView: View {
    
    @State private var showSheet: Bool = false
    @EnvironmentObject var viewModel: HomeViewModel
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    showSheet = true
                }, label: {
                    Image(systemName: "info.circle.fill")
                        .font(.title2)
                        .fontWeight(.medium)
                        .foregroundStyle(.white)
                })
                
                Spacer()
                
                Text("Crypto Pocket")
                    .foregroundStyle(.textCP)
                    .font(.headline)
                    .fontWeight(.medium)
                    .fontDesign(.rounded)
                
                Spacer()
                
                Button(action: {
                    Task {
                        await viewModel.fetchCoinsAndUpdatePortfolio()
                    }
                }, label: {
                    withAnimation {
                        Image(systemName: "bitcoinsign.arrow.circlepath")
                            .font(.title2)
                            .foregroundStyle(.green)
                    }
                })
            }
            .padding(.horizontal)
            
            Divider()
                .background(Color.secondaryTextCP.opacity(0.5))
                .padding(.horizontal)
                .padding(.top, 14)
        }
        .frame(maxWidth: .infinity, alignment: .top)
        .sheet(isPresented: $showSheet, content: {
            AppInfo()
        })
        
    }
}

#Preview {
    ZStack {
        Color.backgroundCP.ignoresSafeArea()
        HeaderView()
            .environmentObject(HomeViewModel())
    }
}
