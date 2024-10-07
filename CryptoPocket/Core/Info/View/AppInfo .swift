//
//  AppInfo .swift
//  CryptoPocket
//
//  Created by Mateusz Krówczyński on 08/09/2024.
//

import SwiftUI

struct AppInfo: View {
    let aboutMe = URL(string: "https://github.com/krowqa2k")!
    let coingeckoURL = URL(string: "https://www.coingecko.com")!
    @Environment(\.dismiss) var dismiss
        
    var body: some View {
        ZStack {
            Color.backgroundCP.ignoresSafeArea()
            
            VStack(spacing: 12) {
                HStack {
                    Text("Creator")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle(.textCP)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading)
                    
                    Button(action: {
                        dismiss()
                    }, label: {
                        Image(systemName: "xmark")
                            .font(.system(size: 25))
                            .foregroundStyle(.white)
                            .background(
                                Circle()
                                    .frame(width: 40, height: 40)
                                    .foregroundStyle(.ultraThinMaterial)
                            )
                            .frame(maxWidth: .infinity, alignment: .topTrailing)
                            .padding(.trailing)
                    })
                }
                HStack(spacing: 12) {
                    Image("creatorImage")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .padding(.leading)
                    Spacer(minLength: 0)
                    
                    VStack(alignment: .leading, spacing: 4){
                        Text("App created by Mateusz Krówczyński.")
                            .font(.callout)
                            .fontWeight(.medium)
                            .foregroundStyle(.white)
                        Text("👇 You can reach me here.")
                            .font(.callout)
                            .fontWeight(.medium)
                            .foregroundStyle(.gray)
                        Link("Github profile.", destination: aboutMe)
                            .foregroundStyle(.blue)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.bottom, 50)
                Text("Coingecko")
                    .font(.title2)
                    .fontWeight(.semibold)
                    .foregroundStyle(.textCP)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.leading)
                VStack(alignment: .leading) {
                    Image("coingecko")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 100)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    
                    Text("The crypto app data that is used in this app comes from API from CoinGecko!")
                        .font(.callout)
                        .fontWeight(.medium)
                        .foregroundStyle(Color.textCP)
                        .padding(.vertical)
                }
                Link("Visit CoinGecko!", destination: coingeckoURL)
                    .foregroundStyle(.blue)
                
                Spacer()
            }
            .padding(.top, 40)
        }
    }
}

#Preview {
    AppInfo()
}
