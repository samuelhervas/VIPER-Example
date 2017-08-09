//
//  FilterTransitionDelegate.swift
//  Lyst
//
//  Created by Samuel Hervás on 14/7/17.
//  Copyright © 2017 Sam Hervas. All rights reserved.
//


class FilterTransitionDelegate: NSObject,UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return SHFilterPresentationTransition()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let filter = SHFilterPresentationTransition()
        filter.isDissmisTransition = true
        return filter
    }
}
