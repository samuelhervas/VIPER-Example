//
//  CollectionViewCell.swift
//  Sam HervasiPad
//
//  Created by Samuel Hervás on 26/9/17.
//  Copyright © 2017 Sam Hervas. All rights reserved.
//

import UIKit

import Haneke

class SneakerCollectionViewCell: UICollectionViewCell, ViewModelReusable {
    
    static let aspectRatio : Float = 3/4
    
    internal var overlayView: UIView {
        get { return overlayViewContainer }
    }
    
    typealias VM = Sneaker
    
    @IBOutlet var overlayViewContainer: UIView!
    
    @IBOutlet var image: UIImageView!
    @IBOutlet var title: UILabel!
    @IBOutlet var price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.image.image = nil
        
    }

    static var reuseType: ReuseType {
        return .nib(UINib.init(nibName: "SneakerCollectionViewCell", bundle: nil))
    }
    
    public static var reuseIdentifier: String {
        return "SneakerCollectionViewCell"
    }
    
    //MARK: ViewModelReusable

    public func configureFor(viewModel: Sneaker) {
        title.text = viewModel.title
        if let imageURL = URL(string: viewModel.imageURL) {
            image.hnk_setImage(from: imageURL)
        }
        price.text = viewModel.price
    }
    
}
