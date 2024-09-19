//
//  SplashLaunchScreen.swift
//  CryptoPocket
//
//  Created by Mateusz Krówczyński on 17/09/2024.
//

import SwiftUI
import Lottie

struct SplashLaunchScreen: View {
    var body: some View {
        ZStack {
            Color.backgroundCP.ignoresSafeArea()
            
            VStack {
                Text("Crypto Pocket💰")
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .fontDesign(.monospaced)
                    .foregroundStyle(.textCP)
                    .offset(y: 50)
                
                LottieView(lottieFile: "CryptoAnimation")
                    .frame(height: 200)
                    .frame(maxWidth: .infinity)
            }
        }
    }
}

struct LottieView: UIViewRepresentable {
    let lottieFile: String
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        
        let animationView = LottieAnimationView()
        animationView.animation = LottieAnimation.named(lottieFile)
        animationView.contentMode = .scaleAspectFit
        animationView.play()
        animationView.loopMode = .loop
        animationView.backgroundBehavior = .pauseAndRestore
        
        view.addSubview(animationView)
        
        animationView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            animationView.widthAnchor.constraint(equalTo: view.widthAnchor),
            animationView.heightAnchor.constraint(equalTo: view.heightAnchor),
            animationView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            animationView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        animationView.animationSpeed = 1.3
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}

#Preview {
    SplashLaunchScreen()
}
