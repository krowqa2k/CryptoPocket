//
//  CryptoPocketApp.swift
//  CryptoPocket
//
//  Created by Mateusz Krówczyński on 29/08/2024.
//

import SwiftUI

@main
struct CryptoPocketApp: App {
    
    @StateObject private var viewModel = HomeViewModel()
    @State private var detailsViewOpened: Bool = false
    
    var body: some Scene {
        WindowGroup {
            HomeView(index: 0, detailsViewOpened: $detailsViewOpened)
                .environmentObject(viewModel)
        }
    }
}
