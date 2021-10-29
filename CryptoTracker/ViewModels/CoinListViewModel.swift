//
//  CoinListViewModel.swift
//  CryptoTracker
//
//  Created by Juan Pablo Ramos on 29/10/21.
//

import Foundation
import Combine

class CoinListViewModel: ObservableObject {
    
    @Published var coins: [CoinModel] = []
    @Published var searchText: String = ""
    
    private let dataService = CoinDataService()
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        addSuscribers()
    }
    
    func addSuscribers() {
        
        $searchText
            .combineLatest(dataService.$allCoins)
            .map(filterCoins)
            .sink { [weak self] returnedCoins in
                self?.coins = returnedCoins
            }
            .store(in: &cancellables)
    }
    
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else {
            return coins
        }
        
        let lowercasedText = text.lowercased()
        
        return coins.filter { coin -> Bool in
            return coin.name.lowercased().contains(lowercasedText) ||
            coin.symbol.lowercased().contains(lowercasedText) ||
            coin.id.lowercased().contains(lowercasedText)
        }
    }
}
