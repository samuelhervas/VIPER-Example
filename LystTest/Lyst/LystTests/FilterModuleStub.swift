//
//  FilterModuleStub.swift
//  Lyst
//
//  Created by Samuel Hervás on 20/7/17.
//  Copyright © 2017 Sam Hervas. All rights reserved.
//

import LystProvider

@testable import Lyst


enum DUTTypes {
    case presenter
    case interactor
    case view
    case router
}


class FilterModulePresenterStub: NSObject, Presenter, FilterModulePresenterProtocol {
    
    weak var view: FilterModuleView?
    var interactor: FilterModuleInteractor?
    var router: FilterModuleRouter?
    
    let product = "Shoes"
    let type = "category"
    
    var category : String = "boots"
    
    var gender: Gender = .female
    
    var categories : [Lyst.Category]?
    
    required init(category: String, gender: Gender) {
        self.category = category
        self.gender = gender
    }
    
    func viewDidLoad() {
    }
    
    func viewWillAppear() {
    }
    
    func didTapCancelButton() {
        
    }
    
    func retrieveCategories() {
        
    }
    
    func changeCategorySelected() {
    }

}


class FilterModuleStub<P:Presenter,V:View,R:Router,I:Interactor>: ModuleProvider {
    
    let category: String
    let gender: Gender
    
    let dut : DUTTypes = .presenter
    
    init(category: String, gender: Gender) {
        self.category = category
        self.gender = gender
    }
    
    var presenter: P {
        if dut == .presenter {
           return FilterModulePresenter(category: category, gender: gender) as! P
        }
        return FilterModulePresenterStub(category: category, gender: gender) as! P
    }
    
    var view: V {
        return FilterModuleView.instantiateView(storyboard: ResourceKey.Storyboard.main.rawValue, identifier: ResourceKey.View.filter.rawValue) as! V
    }
    
    var router: R {
        return FilterModuleRouter() as! R
    }
    
    var interactor: I {
        return FilterModuleInteractor() as! I
    }
    
    required init() {
        self.category = "boots"
        self.gender = .female
    }
}
