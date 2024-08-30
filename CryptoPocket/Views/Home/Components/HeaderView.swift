//
//  headerView.swift
//  CryptoPocket
//
//  Created by Mateusz Krówczyński on 30/08/2024.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    //TODO: app info sheet pop up
                }, label: {
                    Image(systemName: "info.circle.fill")
                        .font(.title2)
                        .fontWeight(.medium)
                        .foregroundStyle(.white)
                })
                
                Spacer()
                
                Text("Crypto Wallet")
                    .foregroundStyle(.textCP)
                    .font(.headline)
                    .fontWeight(.medium)
                    .fontDesign(.rounded)
                    .offset(x: -20)
                
                Spacer()
            }
            .padding(.horizontal)
            
            Divider()
                .background(Color.secondaryTextCP.opacity(0.5))
                .padding(.horizontal)
                .padding(.top, 14)
        }
        .frame(maxWidth: .infinity, alignment: .top)
        
    }
}

#Preview {
    ZStack {
        Color.backgroundCP.ignoresSafeArea()
        HeaderView()
    }
}
