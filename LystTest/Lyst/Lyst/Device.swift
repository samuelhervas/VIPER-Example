//
//  Device.swift
//  Sam HervasiPad
//
//  Created by Samuel Hervás on 17/8/17.
//  Copyright © 2017 Sam Hervas. All rights reserved.
//

import UIKit

enum DeviceType : String {
    case phone = "phone"
    case tablet = "tablet"
}

enum DeviceOrientation : String {
    case portrait = "portrait"
    case landscape = "landscape"
}

struct Device {
    
    var isSimulator: Bool {
        #if IOS_SIMULATOR
            return true
        #else
            return false
        #endif
    }
    
    var deviceType : DeviceType {
        switch UIDevice.current.userInterfaceIdiom  {
        case .pad:
            return .tablet
        case .phone:
            return .phone
        default:
            return .phone
        }
    }
    
    var deviceOrientation : DeviceOrientation {
        switch UIDevice.current.orientation  {
        case .landscapeLeft, .landscapeRight:
            return .landscape
        case .portrait, .portraitUpsideDown:
            return .portrait
        default:
            if UIApplication.shared.statusBarOrientation.isLandscape {
                return .landscape
            } else {
                return .portrait
            }
        }
    }
}
