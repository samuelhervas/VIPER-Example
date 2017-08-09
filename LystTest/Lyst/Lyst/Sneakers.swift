//
//  SneakersDTO.swift
//  Lyst
//
//  Created by Samuel Hervás on 17/7/17.
//  Copyright © 2017 Sam Hervas. All rights reserved.
//

import Foundation
import LystProvider

protocol Sneaker {
    
    
    var imageURL: String { get }
    var title: String { get }
    var price: String { get }
    
}

extension SneakersDTO: Sneaker {
    
    
    var imageURL: String { return image }
    
}
