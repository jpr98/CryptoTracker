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
        ZStack {
            
            VStack {
                headerView
                SearchBarView(searchText: $vm.searchText)
                List {
                    ForEach(vm.coins) { coin in
                        NavigationLink(
                            destination: CoinDetailView(coin: coin, service: WebSocketService(coin: coin))
                        ) {
                            CoinRowView(coin: coin)
                        }
                    }
                }
                .listStyle(PlainListStyle())
                Spacer(minLength: 0)
            }
        }
    }
    
    var headerView: some View {
        HStack {
            Text("Coins")
                .font(.title)
                .fontWeight(.bold)
            
        }
        
    }
    
    var dateFormat: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE"
        return formatter
    }
}

struct CoinListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CoinListView()
                .navigationBarHidden(true)
        }
    }
}
