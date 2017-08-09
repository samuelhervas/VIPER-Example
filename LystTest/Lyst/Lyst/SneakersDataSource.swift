//
//  SneakersDataSource.swift
//  Lyst
//
//  Created by Samuel Hervás on 14/7/17.
//  Copyright © 2017 Sam Hervas. All rights reserved.
//

import UIKit

class SneakersViewDatasource<Model, HeaderModel, Cell: ViewModelReusable>:NSObject, UICollectionViewDataSource
    where Cell:UICollectionViewCell,Cell.VM == Model {
    
    
    weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
        }
    }
    
    init(collectionView: UICollectionView) {
        
        super.init()
        
        self.collectionView = collectionView
        self.collectionView.dataSource = self
        
        switch Cell.reuseType {
        case .nib(let nib):
            self.collectionView.register(nib, forCellWithReuseIdentifier:Cell.reuseIdentifier)
        case .classReference(let klass):
            self.collectionView.register(klass, forCellWithReuseIdentifier: Cell.reuseIdentifier)
        }
    }
    
    var data : ([Model])? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return data?.count ?? 0
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cell.reuseIdentifier, for: indexPath) as! Cell
        guard let viewModel = modelAtIndexPath(indexPath: indexPath) else {
            return cell
        }
        
        cell.configureFor(viewModel: viewModel)
        return cell
    }
    
    func modelAtIndexPath(indexPath: IndexPath) -> Model? {
        
        return data?[indexPath.row]
    }
    
}

