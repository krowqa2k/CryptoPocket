//
//  LineChartView .swift
//  CryptoPocket
//
//  Created by Mateusz Krówczyński on 05/09/2024.
//

import SwiftUI

struct LineChartView: View {
    
    private let data: [Double]
    private let maxY: Double
    private let minY: Double
    private let lineColor: Color
    private let startingDate: Date
    private let endingDate: Date
    @State private var percentage: CGFloat = 0
    
    init(coin: CoinModel) {
        data = coin.sparklineIn7D?.price ?? []
        maxY = data.max() ?? 0
        minY = data.min() ?? 0
        
        let priceChange = (data.last ?? 0) - (data.first ?? 0)
        lineColor = priceChange > 0 ? .green : .red
        
        endingDate = Date()
        startingDate = endingDate.addingTimeInterval(-7*24*60*60)
    }
    
    var body: some View {
        VStack {
            chartView
                .frame(height: 250)
                .padding(.vertical, 4)
                .background(
                    chartBackground
                )
                .overlay(
                    chartOverlay
                    , alignment: .leading
            )
            chartLabels
                .padding(4)
        }
        .onAppear{
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                withAnimation(.linear(duration: 1.2)) {
                    percentage = 1.0
                }
            }
        }
    }
}

#Preview {
    ZStack {
        Color.backgroundCP.ignoresSafeArea()
        LinearGradient(colors: [Color.backgroundCP, Color.backgroundCP.opacity(0.8), Color.black.opacity(0.3), Color.black.opacity(0.4)], startPoint: .topLeading, endPoint: .bottomTrailing).ignoresSafeArea()
        LineChartView(coin: .mock)
    }
}

extension LineChartView {
    private var chartView: some View {
        GeometryReader { geometry in
            Path { path in
                for index in data.indices {
                    
                    let xPosition = geometry.size.width / CGFloat(data.count) * CGFloat(index + 1)
                    
                    let yAxis = maxY - minY
                    
                    let yPosition = (1 - CGFloat((data[index] - minY) / yAxis)) * geometry.size.height
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    }
                    path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                }
            }
            .trim(from: 0, to: percentage)
            .stroke(lineColor, style: StrokeStyle(lineWidth: 4, lineCap: .round, lineJoin: .round))
        }
    }
    
    private var chartBackground: some View {
        VStack {
            Divider()
                .overlay{ Color.secondaryTextCP.opacity(0.6) }
            Spacer(minLength: 0)
            Divider()
                .overlay{ Color.secondaryTextCP.opacity(0.6) }
            Spacer(minLength: 0)
            Divider()
                .overlay{ Color.secondaryTextCP.opacity(0.6) }
        }
    }
    
    private var chartOverlay: some View {
        VStack {
            Text(String(format: "%.2f", maxY))
                .offset(y: -20)
            Spacer(minLength: 0)
            Text(String(format: "%.2f", ((maxY + minY) / 2)))
            Spacer(minLength: 0)
            Text(String(format: "%.2f", minY))
        }
        .foregroundStyle(.textCP)
        .font(.callout)
    }
    
    private var chartLabels: some View {
        HStack {
            Text(startingDate.asShortDateString())
            Spacer(minLength: 0)
            Text(endingDate.asShortDateString())
        }
        .foregroundStyle(.secondaryTextCP)
    }
}
