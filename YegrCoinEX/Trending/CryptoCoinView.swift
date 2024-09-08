//
//  CryptoCoinView.swift
//  YegrCoinEX
//
//  Created by YJ on 9/8/24.
//

import SwiftUI

enum TrendingSection: String {
    case myFavorite = "My Favorite"
    case top15Coin = "Top 15 Coin"
    case top7NFT = "Top 7 NFT"
}

struct CryptoCoinView: View {
    let sectionList: [TrendingSection] = [.myFavorite, .top15Coin, .top7NFT]
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(sectionList, id: \.self) { section in
                    SectionView(sectionTitle: section.rawValue)
                    switch section {
                    case .myFavorite:
                        ScrollView(.horizontal) {
                            HStack(spacing: 0) {
                                MyFavoriteView()
                                MyFavoriteView()
                            }
                        }
                        
                    case .top15Coin:
                        Top15CoinView()
                    case .top7NFT:
                        Top7NFTView()
                    }
                }
                .navigationTitle("Crypto Coin")
            }
        }
    }
}

struct SectionView: View {
    let sectionTitle: String
    
    var body: some View {
        Text(sectionTitle)
            .font(.title2)
            .fontWeight(.semibold)
            .padding(.horizontal)
            .padding(.vertical, 5)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct MyFavoriteView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25)
                .fill(.gray.opacity(0.2))
                .clipShape(RoundedRectangle(cornerRadius: 25))
                .frame(width: 250,height: 200)
                .padding()
            
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "bitcoinsign.circle.fill") // API String으로 넘어올 예정
                        .resizable()
                        .frame(width: 40, height: 40)
                    VStack(alignment:.leading) {
                        Text("Bitcoin")
                            .font(.system(size: 18))
                            .fontWeight(.semibold)
                            .foregroundStyle(.black)
                        Text("BTC")
                            .font(.system(size: 15))
                            .foregroundStyle(.gray)
                    }
                    
                    Spacer()
                }
                
                Spacer()
                
                Text("₩69,234,245")
                    .font(.system(size: 18))
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                    .padding(.vertical, 3)
                Text("+0.64%")
                    .font(.system(size: 16))
                    .fontWeight(.semibold)
                    .foregroundStyle(.red)
            }
            .padding(30)
            .frame(width: 250,height: 200)
        }
    }
}

struct Top15CoinView: View {
    var body: some View {
        Text("Top15CoinView")
    }
}

struct Top7NFTView: View {
    var body: some View {
        Text("Top7NFTView")
    }
}

#Preview {
    CryptoCoinView()
}
