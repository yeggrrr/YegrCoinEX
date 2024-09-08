//
//  NetworkManager.swift
//  YegrCoinEX
//
//  Created by YJ on 9/8/24.
//

import Foundation
import Alamofire

struct NetworkManager {
    
    private init() {}
    
    static func fetchTrendingAPI(completion: @escaping (TrendingModel) -> Void) {
        
        if let url = URL(string: "https://api.coingecko.com/api/v3/search/trending") {
            
            AF.request(url)
                .responseDecodable(of: TrendingModel.self) { response in
                    switch response.result {
                    case .success(let success):
                        completion(success)
                    case .failure(let failure):
                        print("Fail!: \(failure)")
                    }
                }
        }
    }
}
