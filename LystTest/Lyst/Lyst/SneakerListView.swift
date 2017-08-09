//
//  SneakerListView.swift
//  Lyst
//
//  Created by Samuel Hervás on 16/7/17.
//  Copyright © 2017 Sam Hervas. All rights reserved.
//

import Foundation


class SneakersListView: UIViewController, View {
    
    
    @IBOutlet var collectionView: UICollectionView!
    
    var collectionDataSource : SneakersViewDatasource<Sneaker, String,
    SneakerCollectionViewCell>?
    
    var presenter: SneakersListPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionDataSource = SneakersViewDatasource<Sneaker, String,
            SneakerCollectionViewCell>(collectionView: collectionView)
        
        presenter?.viewDidLoad()
        collectionView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setLogoAsTitle()
        self.presenter?.viewWillAppear()
    }
    
    @IBAction func didTapViewFilters(_ sender: Any) {
        presenter?.didTapViewFilters()
    }
    
    func didLoadData(sneakers: [Sneaker]) {
        self.collectionDataSource?.data = sneakers
    }
    
}

extension SneakersListView: UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}


extension SneakersListView: Columnable {
    
    
    var cellWidth : Float { get { return 100 } }
    var cellHeight : Float {  get { return 150 } }
    
    func numberOfItemsPerRow(indexPath: IndexPath?) -> Float {
        let device = Device()
        switch (device.deviceOrientation, device.deviceType) {
        case (.portrait, .phone):
            return 2
        case (.landscape, .phone):
            return 3
        default:
            return 4
        }
    }
    
    func cellAspectRatio() -> Float {
        return cellWidth/cellHeight
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return cellSize(collectionView: collectionView, flowLayout: collectionViewLayout as! UICollectionViewFlowLayout, indexPath: indexPath)
    }
    
}
