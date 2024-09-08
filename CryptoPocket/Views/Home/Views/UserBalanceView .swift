//
//  UserBalanceView .swift
//  CryptoPocket
//
//  Created by Mateusz Krówczyński on 30/08/2024.
//

import SwiftUI

struct UserBalanceView: View {
    
    @State private var isProfit: Bool = true
    
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            HStack {
                Text("Your Balance")
                    .font(.system(size: 18))
                    .fontWeight(.medium)
                    .foregroundStyle(.secondaryTextCP)
                
                Text("+37,2%")
                    .font(.callout)
                    .foregroundStyle(.black)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .foregroundStyle(isProfit ? .green : .red)
                    )
            }
            
            Text("$17258.13")
                .font(.system(size: 45))
                .fontWeight(.medium)
                .foregroundStyle(.textCP)
                .fontDesign(.rounded)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 12)
                .foregroundStyle(.ultraThinMaterial.opacity(0.5))
        )
        .padding(.horizontal)
        
    }
}

#Preview {
    ZStack {
        Color.backgroundCP.ignoresSafeArea()
        UserBalanceView()
    }
}
