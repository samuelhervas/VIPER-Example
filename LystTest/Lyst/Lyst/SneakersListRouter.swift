//
//  SneakersListRouter.swift
//  Lyst
//
//  Created by Samuel Hervás on 16/7/17.
//  Copyright © 2017 Sam Hervas. All rights reserved.
//

import Foundation

import LystProvider

class SneakersListRouter: Router {
    
    weak var view: SneakersListView?
    
    lazy var filterTransitionDelegate = { return FilterTransitionDelegate() }()
    
    func goToFilter(category: String, gender: Gender, delegate:FilterDelegate) {
        
        let filter = Module<FilterModule>.build(provider: FilterModule.init(category: category, gender: gender))
        filter.router.view?.filterDelegate = delegate
        filter.show(in: .view(view!, embeded: true, modal: true, transitionDelegate: filterTransitionDelegate))
    }
    
}
