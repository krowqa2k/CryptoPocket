//
//  TabView .swift
//  CryptoPocket
//
//  Created by Mateusz Krówczyński on 02/09/2024.
//

import SwiftUI

struct TabView: View {
    
    @Binding var index: Int
    @State private var showSheet: Bool = false
    let width: CGFloat = UIScreen.main.bounds.width
    
    var body: some View {
        ZStack {
            ZStack {
                UnevenRoundedRectangle(
                    topLeadingRadius: 12,
                    topTrailingRadius: 12
                )
                .fill(Gradient(colors: [Color.backgroundCP, Color.black.opacity(0.2)]))
                .frame(width: width, height: 80)
                
                HStack {
                    Button(action: {
                        self.index = 0
                    }, label: {
                        Image(systemName: "house.fill")
                            .font(.title)
                            .foregroundStyle(self.index == 0 ? .textCP : .secondaryTextCP)
                            .tag(0)
                    })
                    .offset(x: 70, y: -10)
                    
                    Spacer()
                    
                    Button(action: {
                        self.index = 1
                    }, label: {
                        Image(systemName: "bitcoinsign.arrow.circlepath")
                            .font(.title)
                            .foregroundStyle(self.index == 1 ? .textCP : .secondaryTextCP)
                            .tag(0)
                    })
                    .offset(x: -70, y: -10)
                    
                }
            }
            
            ZStack {
                Circle()
                    .fill(Color.componentsCP)
                    .frame(width: 50, height: 50)
                
                Button(action: {
                    showSheet.toggle()
                }, label: {
                    Image(systemName: "plus")
                        .font(.title2)
                        .fontWeight(.medium)
                        .foregroundStyle(.textCP)
                })
            }
            .offset(y: -30)
        }
    }
}

#Preview {
    ZStack {
        Color.backgroundCP.ignoresSafeArea()
        LinearGradient(colors: [Color.backgroundCP, Color.backgroundCP.opacity(0.8), Color.black.opacity(0.3), Color.black.opacity(0.4)], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
        TabView(index: .constant(0))
    }
}
