//
//  FilterModuleInteractor.swift
//  Lyst
//
//  Created by Samuel Hervás on 16/7/17.
//  Copyright © 2017 Sam Hervas. All rights reserved.
//

import Foundation

import LystProvider

class FilterModuleInteractor: Interactor {
    
    weak var presenter: FilterModulePresenter?
    
    func retrieveCategories(gender: Gender, product: String, type: String, completion: @escaping  ResultCategoriesBlock) {
        ListProvider.retrieveCategories(gender: gender, product: product, type: type, completion: completion)
    }
    
}
