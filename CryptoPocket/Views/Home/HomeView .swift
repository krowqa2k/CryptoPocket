//
//  HomeView .swift
//  CryptoPocket
//
//  Created by Mateusz Krówczyński on 30/08/2024.
//

import SwiftUI

struct HomeView: View {
    
    @State var index: Int
    
    var body: some View {
        ZStack {
            background
            
            VStack {
                switch index {
                case 0:
                    defaultView
                case 1:
                    AllCoinsList()
                default:
                    defaultView
                }
                
                Spacer(minLength: 0)
                TabView(index: $index)
            }
            .ignoresSafeArea(edges: .bottom)
        }
    }
    
    private var defaultView: some View {
        VStack(spacing: 32) {
            HeaderView()
            
            UserBalanceView()
            
            Spacer(minLength: 0)
        }
    }
    
    private var background: some View {
        ZStack {
            Color.backgroundCP.ignoresSafeArea()
            LinearGradient(colors: [Color.backgroundCP, Color.backgroundCP.opacity(0.8), Color.black.opacity(0.3), Color.black.opacity(0.4)], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
        }
    }
}

#Preview {
    HomeView(index: 0)
}
