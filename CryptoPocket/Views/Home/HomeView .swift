//
//  HomeView .swift
//  CryptoPocket
//
//  Created by Mateusz Krówczyński on 30/08/2024.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        ZStack {
            Color.backgroundCP.ignoresSafeArea()
            
            VStack {
                HeaderView()
                
                Spacer(minLength: 0)
            }
        }
    }
}

#Preview {
    HomeView()
}
