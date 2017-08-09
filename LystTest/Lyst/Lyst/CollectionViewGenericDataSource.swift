//
//  CollectionViewGenericDataSource.swift
//  Lyst
//
//  Created by Samuel Hervás on 14/7/17.
//  Copyright © 2017 Sam Hervas. All rights reserved.
//

import Foundation

import UIKit

public protocol ViewModelConfigurable {
    
    
    associatedtype VM
    func configureFor(viewModel: VM) -> Void
}

public protocol ViewModelReusable: ViewModelConfigurable {
    
    
    static var reuseType: ReuseType { get }
    static var reuseIdentifier: String { get }
}

public protocol ViewModelHashable: ViewModelReusable {
    
    
    associatedtype VM: Hashable
}

public protocol ViewModelComparable: ViewModelHashable {
    
    
    associatedtype VM: Comparable
}

public enum ReuseType {
    case nib(UINib)
    case classReference(AnyClass)
}

extension ViewModelReusable where Self: UICollectionReusableView {
    
    
    public static var reuseIdentifier: String {
        return String.className(aClass: self)
    }
    
    public static var reuseType: ReuseType {
        return .classReference(Self.self)
    }
}

private extension String {
    
    static func className(aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last ?? ""
    }
}
