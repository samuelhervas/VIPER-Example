//
//  Category.swift
//  Lyst
//
//  Created by Samuel Hervás on 15/7/17.
//  Copyright © 2017 Sam Hervas. All rights reserved.
//

import Foundation
import LystProvider

protocol Category {
    var name : String { get }
    var value: String { get }
}

extension CategoryCallDTO: Category {
    
    var name : String {
        return label
    }
    
    
}
