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

struct MyFavorite {
    let icon: String
    let name: String
    let symbol: String
    let currentPrice: Int
    let percentage: Double
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
                .frame(width: 240,height: 180)
                .padding()
            
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "bitcoinsign.circle.fill")
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
            .frame(width: 240,height: 180)
        }
    }
}

struct Top15: Hashable, Identifiable {
    let id = UUID()
    let rank: Int
    let thumb: String
    let name: String
    let symbol: String
    let price: Double
    let percent: Double
}

struct Top15CoinView: View {
    @State private var top15List: [Top15] = []
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                let splitList = splitItems(count: 3, items: top15List)
                
                ForEach(splitList, id: \.self) { list in
                    Top15VerticalView(list: list)
                }
            }
            .onAppear(perform: onAppear)
        }
    }
    
    func onAppear() {
        // NetworkManager.fetchTrendingAPI { coinData in
        //     print(coinData)
        //     top15List = coinData.coins.map { Top15(
        //         thumb: $0.item.small,
        //         name: $0.item.name,
        //         symbol: $0.item.symbol,
        //         price: $0.item.data.price,
        //         percent: $0.item.data.price_change_percentage_24h.krw) }
        // }

        // Test dummy data
        top15List = NetworkManager.createDummyData()
    }
    
    func splitItems(count: Int, items: [Top15]) -> [[Top15]] {
        var doubleArray: [[Top15]] = []
        var array: [Top15] = []
        
        for i in 0..<items.count {
            array.append(items[i])
            
            if array.count == count {
                doubleArray.append(array)
                array = []
            } else {
                let lastIndex = items.count - 1
                if i == lastIndex {
                    doubleArray.append(array)
                }
            }
        }
        
        return doubleArray
    }
    
    struct Top15VerticalView: View {
        let list: [Top15]
        
        var body: some View {
            
            VStack {
                ForEach(list, id: \.id) { item in
                    Top15CellView(item: item)
                }
            }
        }
    }
    
    struct Top15CellView: View {
        
        let item: Top15
        
        var body: some View {
            HStack(spacing: 0) {
                Text("\(item.rank)")
                    .font(.system(size: 20, weight: .bold))
                Spacer().frame(width: 15)
                AsyncImage(url: URL(string: item.thumb)) { result in
                    result.image?
                        .resizable()
                        .frame(width: 35, height: 35)
                }
                Spacer().frame(width: 15)
                VStack(alignment: .leading) {
                    Text(item.name)
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundStyle(.black)
                    Text(item.symbol)
                        .font(.system(size: 15, weight: .regular))
                        .foregroundStyle(.gray)
                }
                Spacer()
                VStack(alignment: .trailing) {
                    Text("$\(String(format: "%.4f", item.price))")
                    if item.percent <= 0 {
                        Text("\(String(format: "%.2f", item.percent))%")
                            .foregroundStyle(.blue)
                    } else {
                        Text("\(String(format: "%.2f", item.percent))%")
                            .foregroundStyle(.red)
                    }
                }
            }
            .padding(.horizontal)
            .padding(.vertical)
        }
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
