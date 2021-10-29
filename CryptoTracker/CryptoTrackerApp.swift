//
//  CryptoTrackerApp.swift
//  CryptoTracker
//
//  Created by Juan Pablo Ramos on 28/10/21.
//

import SwiftUI

@main
struct CryptoTrackerApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                CoinListView()
                    .navigationBarHidden(true)
            }
        }
    }
}
