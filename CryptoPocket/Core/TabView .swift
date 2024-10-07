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
                TabViewRectangle()
                    .fill(Gradient(colors: [Color.backgroundCP, Color.black.opacity(0.2)]))
                    .frame(width: width, height: 80)
                    .cornerRadius(12)
                
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
        .sheet(isPresented: $showSheet, content: {
            AddCoinView()
        })
    }
}

#Preview {
    ZStack {
        Color.backgroundCP.ignoresSafeArea()
        LinearGradient(colors: [Color.backgroundCP, Color.backgroundCP.opacity(0.8), Color.black.opacity(0.3), Color.black.opacity(0.4)], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
        TabView(index: .constant(0))
    }
}

struct TabViewRectangle: Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: CGPoint(x: 0, y: 0))
                    path.addLine(to: CGPoint(x: rect.width * 0.35, y: 0))
                    path.addArc(center: CGPoint(x: rect.width * 0.35, y: rect.height * 0.5),
                                radius: rect.height * 0.5,
                                startAngle: .degrees(180),
                                endAngle: .degrees(90),
                                clockwise: false)
                    path.addLine(to: CGPoint(x: 0, y: rect.height))
                    
                    path.closeSubpath()

                    let circleRadius = rect.height * 0.4
                    path.addArc(center: CGPoint(x: rect.width * 0.5, y: rect.height - 30),
                                radius: circleRadius,
                                startAngle: .degrees(0),
                                endAngle: .degrees(360),
                                clockwise: false)

                    path.move(to: CGPoint(x: rect.width * 0.65, y: 0))
                    path.addLine(to: CGPoint(x: rect.width, y: 0))
                    path.addLine(to: CGPoint(x: rect.width, y: rect.height))
                    path.addLine(to: CGPoint(x: rect.width * 0.65, y: rect.height))
                    path.addArc(center: CGPoint(x: rect.width * 0.65, y: rect.height * 0.5),
                                radius: rect.height * 0.5,
                                startAngle: .degrees(90),
                                endAngle: .degrees(-90),
                                clockwise: false)
                    path.closeSubpath()
        }
    }
}
