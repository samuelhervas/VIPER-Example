//
//  SneakersListInteractor.swift
//  Lyst
//
//  Created by Samuel Hervás on 16/7/17.
//  Copyright © 2017 Sam Hervas. All rights reserved.
//

import Foundation

import LystProvider

protocol SneakerInteractor {
    
    func retrieve(gender: Gender, category: String, completion: @escaping (ResultSneakersBlocks))
}

class SneakersListInteractor: Interactor, SneakerInteractor {
    
    weak var presenter: SneakersListPresenter?
    
}

extension SneakerInteractor where Self:SneakersListInteractor, Self:Interactor {
    
    
    func retrieve(gender: Gender, category: String, completion: @escaping (ResultSneakersBlocks)) {
        ListProvider.retrieveFeeds(gender: gender, category: category, completion: completion)
    }
    
}
