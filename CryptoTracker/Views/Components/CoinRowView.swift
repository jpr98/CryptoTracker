//
//  CoinRowView.swift
//  CryptoTracker
//
//  Created by Franco Garza on 29/10/21.
//

import SwiftUI

struct CoinRowView: View {
    
    let coin: CoinModel
    
    var body: some View {
        HStack(spacing: 0){
            leftColumn
            Spacer()
            rightColumn
        }
        .font(.subheadline)
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        CoinRowView(coin: dev.coin)
            .previewLayout(.sizeThatFits)
    }
}

extension CoinRowView {
    
    private var leftColumn: some View {
        HStack(spacing: 0){
            Text("\(coin.marketCapRank!)")
                .font(.caption)
                .foregroundColor(Color(.black))
                .frame(minWidth: 30)
            CoinImageView(coin: coin)
                .frame(width: 30, height: 30)
            Text(coin.symbol.uppercased())
                .font(.headline)
                .padding(.leading, 6)
                .foregroundColor(Color(.gray))
        }
    }
    
    private var rightColumn: some View {
        
        VStack(alignment: .trailing){
            Text(coin.currentPrice.asCurrencyWith6Decimals())
                .bold()
                .foregroundColor(Color(.black))
            Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                .foregroundColor(
                    (coin.priceChangePercentage24H ?? 0) >= 0 ?
                    Color(.green):
                        Color(.red)
                )
        }
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }
    
}
