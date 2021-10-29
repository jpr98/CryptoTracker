//
//  CoinListView.swift
//  CryptoTracker
//
//  Created by Juan Pablo Ramos on 28/10/21.
//

import SwiftUI

struct CoinListView: View {
    
    @ObservedObject var vm = CoinListViewModel()
    
    var body: some View {
        VStack {
            headerView
            SearchBarView(searchText: $vm.searchText)
            List {
                ForEach(vm.coins) { coin in
                    CoinRowView(coin: coin)
                }
            }
            .listStyle(PlainListStyle())
        }
    }
    
    var headerView: some View {
        HStack {
            Color.blue
        }
    }
}

struct CoinListView_Previews: PreviewProvider {
    static var previews: some View {
        CoinListView()
    }
}
