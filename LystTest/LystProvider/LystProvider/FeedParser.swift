//
//  FeedParser.swift
//  Lyst
//
//  Created by Samuel Hervás on 14/7/17.
//  Copyright © 2017 Sam Hervas. All rights reserved.
//

import Foundation
import Result

class FeedParser {
    
    func parseFeed(data:Data) -> Result<[SneakersDTO],NSError> {
        do {
            if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? Dictionary<String, Any>, let data = jsonResponse["products"] as? Array<Dictionary<String, Any>> {
                
                return .success(data.map({ (dictionary) -> SneakersDTO in
                    return SneakersDTO.init(dictionary:dictionary)
                }))
            }
        } catch {
            return .failure(NSError(domain:"Unexpected error", code: 0, userInfo: nil))
        }
        return .failure(NSError(domain:"Unexpected error", code: 0, userInfo: nil))
    }
}
