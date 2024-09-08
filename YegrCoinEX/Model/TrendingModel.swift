//
//  TrendingModel.swift
//  YegrCoinEX
//
//  Created by YJ on 9/8/24.
//

import Foundation

struct TrendingModel: Decodable {
    let coins: [Coins]
    let nfts: [Nfts]
    
    struct Coins: Decodable {
        let item: Item
        
        struct Item: Decodable {
            let id: String
            let name: String
            let symbol: String
            let small: String
            let data: PriceData
            let sparkline: String?
        }
        
        struct PriceData: Decodable {
            let price: Double
            let price_change_percentage_24h: Percentage24h
            
            struct Percentage24h: Decodable {
                let krw: Double
            }
        }
    }
    
    struct Nfts: Decodable {
        let name: String
        let symbol: String
        let thumb: String
        let data: NftsData
        
        struct NftsData: Decodable {
            let floor_price: String
            let floor_price_in_usd_24h_percentage_change: String
        }
    }
}
