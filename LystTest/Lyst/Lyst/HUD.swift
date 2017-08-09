//
//  HUD.swift
//  Lyst
//
//  Created by Samuel Hervás on 15/7/17.
//  Copyright © 2017 Sam Hervas. All rights reserved.
//


import UIKit

enum HUDState {
    case animated
    case stopped
}

enum HUDType {
    case indicator
    case image
}

class HUD : UIView {
    
    fileprivate let icon : UIImageView = UIImageView.init(image: #imageLiteral(resourceName: "headerLogo"))
    fileprivate let activityIndicator = UIActivityIndicatorView.init(activityIndicatorStyle: .gray)
    fileprivate let contentView = { UIView.init(frame: CGRect(x: 0,y: 0, width: 60, height: 60)) }()
    fileprivate var status : HUDState = { .stopped }()
    
    fileprivate let type : HUDType
    
    init(container:UIView ,type:HUDType) {
        self.type = type
        super.init(frame: container.frame)
        initialise()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.type = .indicator
        super.init(coder: aDecoder)
        initialise()
    }
    
    func initialise() {

        isHidden = true
        addSubview(contentView)
        
        autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        contentView.autoresizingMask = []
        contentView.center = self.center
        
        switch type {
        case .image:
            contentView.addSubview(icon)
            icon.frame = contentView.bounds
            icon.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            icon.contentMode = .center
            contentView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
            contentView.layer.cornerRadius = 7
        case .indicator:
            self.addSubview(activityIndicator)
            activityIndicator.center = self.center
        }
        
        status = .stopped
        NotificationCenter.default.addObserver(self, selector: #selector(deviceOrientationDidChange), name: Notification.Name.UIDeviceOrientationDidChange, object: nil)
    }
    
    override func layoutSubviews() {
        contentView.center = self.center
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    func show(_ animated:Bool) {
        status = (animated) ? .animated : .stopped
        switch status {
        case .animated:
            animate()
        case .stopped:
            stop()
        }
        self.isHidden = false
    }
    
    func hide() {
        status = .stopped
        self.isHidden = true
    }
    
    func animate() {
        stop()
        
        switch type {
        case .image :
            let animation : CABasicAnimation = CABasicAnimation.init(keyPath: "transform.rotation.y")
            animation.fromValue = 0
            animation.toValue = 2 * Double.pi
            animation.duration = 0.75
            animation.repeatCount = Float.infinity
            animation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionLinear);
            icon.layer.add(animation, forKey: "rotation")
        case .indicator:
            activityIndicator.startAnimating()
        }
        
    }
    
    func stop() {
        icon.layer.removeAllAnimations()
    }
    
    func deviceOrientationDidChange(_ notification: Notification) {
        if let superview = self.superview {
            self.frame = superview.frame
        }
    }
}
