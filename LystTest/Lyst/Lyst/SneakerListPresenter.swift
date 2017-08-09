//
//  SneakerListPresenter.swift
//  Lyst
//
//  Created by Samuel Hervás on 16/7/17.
//  Copyright © 2017 Sam Hervas. All rights reserved.
//

import Foundation

import LystProvider

class SneakersListPresenter: Presenter {
    
    
    weak var view: SneakersListView?
    var interactor: SneakersListInteractor?
    var router: SneakersListRouter?
    
    var gender : Gender = .female
    var category: String = "boots"
    
    lazy var hud : HUD = { return HUD.init(container: self.view!.view, type: .image) }()
    
    func viewDidLoad() {
        self.view?.view.addSubview(hud)
    }
    
    func viewWillAppear() {
        
        retrieveSneaker(gender: gender, category: category)
    }
    
    func retrieveSneaker(gender: Gender, category: String) {
        
        hud.show(true)
        self.interactor?.retrieve(gender: gender, category: category, completion: { [weak self]  (result) in
            self?.hud.hide()
            switch result {
            case .success(let sneakers):
                self?.view?.didLoadData(sneakers: sneakers)
            case .failure:
                print("Error: Loading Shoes")
            }
        })
    }
    
    func didTapViewFilters() {
        self.router?.goToFilter(category: category, gender: gender, delegate: self)
    }
}

extension SneakersListPresenter: FilterDelegate {
    
    
    func didSelect(gender: Gender, category: String) {
        self.gender = gender
        self.category = category
        retrieveSneaker(gender: self.gender, category: category)
    }
}
