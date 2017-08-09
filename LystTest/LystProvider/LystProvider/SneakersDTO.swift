//
//  SneakersDTO.swift
//  Lyst
//
//  Created by Samuel Hervás on 14/7/17.
//  Copyright © 2017 Sam Hervas. All rights reserved.
//

import Foundation


public struct SneakersDTO {
    
    public let designerSlug: String
    public let slug: String
    public let title: String
    public let image: String
    public let price: String
    public let onSale: Bool
    public let salePrice: String
    public let discount: String
    public let designerName: String
    public let isPinned: Bool
    public let inStock: Bool
    public let freeShipping: Bool
    public let isIcon: Bool
}

extension SneakersDTO {
    
    init(dictionary:Dictionary<String, Any>) {
        // This should be refactor and use a better solution
        // Using a framework like Unbox.
        self.init(designerSlug: dictionary["designer_slug"] as! String,
                  slug: dictionary["slug"] as! String,
                  title: dictionary["title"] as! String,
                  image: dictionary["image"] as! String,
                  price: dictionary["price"] as! String,
                  onSale: (dictionary["on_sale"] != nil),
                  salePrice: dictionary["sale_price"] as! String,
                  discount: dictionary["discount"] as! String,
                  designerName: dictionary["designer_name"] as! String,
                  isPinned: (dictionary["is_pinned"] != nil),
                  inStock: (dictionary["in_stock"] != nil),
                  freeShipping: (dictionary["free_shipping"] != nil),
                  isIcon: (dictionary["is_icon"] != nil))
        
    }

}

