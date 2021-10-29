//
//  CoinDetailView.swift
//  CryptoTracker
//
//  Created by Juan Pablo Ramos on 29/10/21.
//

import SwiftUI

struct CoinDetailView: View {
    var coin: CoinModel
    @ObservedObject var service: WebSocketService
    
    var body: some View {
        VStack {
            CoinImageView(coin: coin)
                .frame(width: 100, height: 100)
                .padding()
                .padding(.top, 50)
            
            HStack {
                Text(coin.symbol.uppercased())
                    .font(.title2)
                    .foregroundColor(Color.theme.accent)
                Image(systemName: "arrow.right")
                    .foregroundColor(Color.theme.accent)
                Text("USD")
                    .foregroundColor(Color.theme.accent)
                    .font(.title2)
            }
            
            Text(service.priceResult.isEmpty ? "$0.00" : service.priceResult)
                .font(.title)
                .foregroundColor(Color.theme.accent)
                .padding(.bottom, 20)
            
            ChartView(coin: coin)
                .padding()
            Text("Last 7 days")
                .foregroundColor(Color.theme.accent)
                .padding(.top, 8)
            Spacer(minLength: 0)
        }
        .onAppear {
            self.service.connect()
        }
    }
}

struct CoinDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CoinDetailView(coin: dev.coin, service: WebSocketService(coin: dev.coin))
            .preferredColorScheme(.dark)
    }
}
