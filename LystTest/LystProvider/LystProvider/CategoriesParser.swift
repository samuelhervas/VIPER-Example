//
//  CategoriesParser.swift
//  Lyst
//
//  Created by Samuel Hervás on 15/7/17.
//  Copyright © 2017 Sam Hervas. All rights reserved.
//

import Foundation
import Result

class CategoriesParser {
    
    func parseFeed(data:Data) -> Result<[CategoryCallDTO],NSError> {
        do {
            if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? Dictionary<String, Any>, let data = jsonResponse["filters"] as? Array<Dictionary<String, Any>> {
                
                return .success(data.flatMap({ (dictionary) -> CategoryCallDTO? in
                    return CategoryCallDTO.init(dictionary:dictionary)
                }))
            }
        } catch {
            return .failure(NSError(domain:"Unexpected error", code: 0, userInfo: nil))
        }
        return .failure(NSError(domain:"Unexpected error", code: 0, userInfo: nil))
    }
}
