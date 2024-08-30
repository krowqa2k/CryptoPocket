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
        VStack(alignment: .leading, spacing: 4) {
            Text("Your Balance")
                .font(.callout)
                .fontWeight(.medium)
                .foregroundStyle(.secondaryTextCP)
            
            HStack {
                Text("$17258.13")
                    .font(.system(size: 45))
                    .fontWeight(.medium)
                    .foregroundStyle(.textCP)
                    .fontDesign(.rounded)
                
                VStack(alignment: .leading) {
                    Text("+37,2%")
                        .foregroundStyle(isProfit ? .green : .red)
                    
                    Text("All time")
                        .font(.callout)
                        .foregroundStyle(.secondaryTextCP.opacity(0.4))
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal)
    }
}

#Preview {
    ZStack {
        Color.backgroundCP.ignoresSafeArea()
        UserBalanceView()
    }
}
