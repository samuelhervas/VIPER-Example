//
//  FilterModule.swift
//  Lyst
//
//  Created by Samuel Hervás on 15/7/17.
//  Copyright © 2017 Sam Hervas. All rights reserved.
//


import UIKit

import LystProvider

protocol FilterDelegate: class {
    
    func didSelect(gender:Gender, category: String)
}

class FilterModule: ModuleProvider {
    
    let category: String
    let gender: Gender
    
    init(category: String, gender: Gender) {
        self.category = category
        self.gender = gender
    }
    
    var presenter: FilterModulePresenter {
        return FilterModulePresenter(category: category, gender: gender)
    }
    
    var view: FilterModuleView {
        return FilterModuleView.instantiateView(storyboard: ResourceKey.Storyboard.main.rawValue, identifier: ResourceKey.View.filter.rawValue) as! FilterModuleView
    }
    
    var router: FilterModuleRouter {
        return FilterModuleRouter()
    }
    
    var interactor: FilterModuleInteractor {
        return FilterModuleInteractor()
    }
    
    required init() {
        self.category = "boots"
        self.gender = .female
    }
}

