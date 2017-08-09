//
//  File.swift
//  Lyst
//
//  Created by Samuel Hervás on 15/7/17.
//  Copyright © 2017 Sam Hervas. All rights reserved.
//

import Foundation

public struct CategoryCallDTO {
    
    public let value: String
    public let available: Bool
    public let active: Bool
    public let type: String
    public let children: [CategoryCallDTO]?
    public let label: String

}

extension CategoryCallDTO {
    
    init?(dictionary:Dictionary<String, Any>) {
        // This should be refactor and use a better solution
        // Using a framework like Unbox.
        
        guard let value = dictionary["value"] as? String,
            let available = dictionary["available"] as? Bool,
            let active = dictionary["active"] as? Bool,
            let type = dictionary["type"] as? String,
            let label = dictionary["label"]  as? String else  {
            return nil
        }
        
        guard let array = dictionary["children"] as? Array<Dictionary<String, Any>> else {
            self.init(value: value,
                      available: available,
                      active: active,
                      type: type,
                      children: nil,
                      label: label)
            return
        }
        
        let children = array.flatMap { (dictionary) -> CategoryCallDTO? in
            return CategoryCallDTO.init(dictionary: dictionary)
        }
        
        self.init(value: value,
                  available: available,
                  active: active,
                  type: type,
                  children: children,
                  label: label)
        
    }
}
