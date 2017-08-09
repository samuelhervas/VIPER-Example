//
//  UICollectionViewFlowLayout+Columns.swift
//  Sam HervasiPad
//
//  Created by Samuel Hervás on 2/9/17.
//  Copyright © 2017 Sam Hervas. All rights reserved.
//

import UIKit

protocol AspectRatioProtocol {
    static func aspectRatio() -> Float
}

protocol Columnable : UICollectionViewDelegateFlowLayout {
    func numberOfItemsPerRow(indexPath: IndexPath?) -> Float
    func cellAspectRatio() -> Float
}

extension UICollectionViewDelegateFlowLayout where Self: Columnable {
    
    func cellSize(collectionView: UICollectionView, flowLayout: UICollectionViewFlowLayout, indexPath: IndexPath?) -> CGSize {
        let numberOfItems = numberOfItemsPerRow(indexPath: indexPath)
        
        let totalSpace = flowLayout.sectionInset.left
            + flowLayout.sectionInset.right
            + (flowLayout.minimumInteritemSpacing * CGFloat(numberOfItems - 1))
        let width = (collectionView.bounds.width - totalSpace) / CGFloat(numberOfItems)
        let height = CGFloat(width)/CGFloat(cellAspectRatio())
        
        return CGSize(width: width, height: height)
    }
    
    func cellSize(collectionView: UICollectionView, flowLayout: UICollectionViewFlowLayout) -> CGSize {
        return cellSize(collectionView: collectionView, flowLayout: flowLayout, indexPath: nil)
    }
}
