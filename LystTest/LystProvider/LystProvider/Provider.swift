//
//  Provider.swift
//  Lyst
//
//  Created by Samuel Hervás on 14/7/17.
//  Copyright © 2017 Sam Hervas. All rights reserved.
//

import Foundation
import Moya
import Result

public typealias ResultSneakersBlocks = (Result<[SneakersDTO], NSError>) -> Void
public typealias ResultCategoriesBlock = (Result<[CategoryCallDTO], NSError>) -> Void


public final class ListProvider {
    
    public static func retrieveFeeds(gender: Gender, category: String, completion: @escaping ResultSneakersBlocks) {
        
        let provider = MoyaProvider<Feeds>()
        provider.request(.feed(gender: gender,category: category)) { result in
            switch result {
            case let .success(moyaResponse):
                completion(FeedParser().parseFeed(data: moyaResponse.data))
            case .failure:
                completion(.failure(NSError(domain:"Network Error", code: 0, userInfo: nil)))
            }
            
        }
    }
    
    public static func retrieveCategories(gender: Gender, product: String, type: String, completion: @escaping  ResultCategoriesBlock) {
        
        let provider = MoyaProvider<CategoryCall>()
        provider.request(.categories(gender: gender, product: product, type: type), completion: { result in
            switch result {
            case let .success(moyaResponse):
                completion(CategoriesParser().parseFeed(data: moyaResponse.data))
            case .failure:
                completion(.failure(NSError(domain:"Network Error", code: 0, userInfo: nil)))
            }
            
        })
    }

}



