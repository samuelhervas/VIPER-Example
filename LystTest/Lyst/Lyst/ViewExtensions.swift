//
//  ViewExtensions.swift
//  
//
//  Created by Samuel Hervás on 7/7/17.
//  Copyright © 2017 Sam Hervas. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func show(_ vc: UIViewController) {
        self.show(vc, sender: nil)
    }
    
    static func instantiateView(storyboard:String,identifier:String) -> UIViewController {
        return UIStoryboard.init(name: storyboard, bundle: nil).instantiateViewController(withIdentifier: identifier)
    }
    
    func setLogoAsTitle() {
        navigationItem.title = nil
        navigationItem.titleView = UIImageView.init(image:#imageLiteral(resourceName: "headerLogo"))
    }
}
