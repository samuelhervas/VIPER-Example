//
//  SneakersListModule.swift
//
//
//  Created by Samuel Hervás on 7/7/17.
//  Copyright © 2017 Sam Hervas. All rights reserved.
//

import UIKit


class SneakersListModule: ModuleProvider {
    
    
    var presenter: SneakersListPresenter {
        return SneakersListPresenter()
    }
    
    var view: SneakersListView {
        return SneakersListView.instantiateView(storyboard: ResourceKey.Storyboard.main.rawValue, identifier: ResourceKey.View.sneakersList.rawValue) as! SneakersListView
    }
    
    var router: SneakersListRouter {
        return SneakersListRouter()
    }
    
    var interactor: SneakersListInteractor {
        return SneakersListInteractor()
    }
    
    required init() {
        
    }
}

