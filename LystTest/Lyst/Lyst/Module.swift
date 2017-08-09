//
//  Module.swift
//
//
//  Created by Samuel Hervás on 7/7/17.
//  Copyright © 2017 Sam Hervas. All rights reserved.
//

import Foundation
import UIKit

protocol Presenter: class {
    associatedtype V : AnyObject
    associatedtype I : AnyObject
    associatedtype W : AnyObject
    
    weak var view: V? { get set }
    var interactor: I? { get set }
    var router: W? { get set }
}

protocol View: class {
    associatedtype P : Presenter
    var presenter: P? { get set }
}

protocol Router: class {
    associatedtype V : View
    weak var view: V? { get set }
}

protocol Interactor: class {
    associatedtype P : Presenter
    weak var presenter: P? { get set }
    
}

protocol ModuleProvider: class {
    associatedtype P : Presenter
    associatedtype I : Interactor
    associatedtype V : View
    associatedtype R : Router
    
    var presenter: P { get }
    var view: V  { get }
    var router: R  { get }
    var interactor: I  { get }
    
    init()
}


class Module<PR:ModuleProvider> {
    
    var presenter: PR.P
    var view: PR.V
    var router: PR.R
    var interactor: PR.I
    
    init(provider:PR) {
        presenter = provider.presenter
        view = provider.view
        interactor = provider.interactor
        router = provider.router
    }
    
    static func build(provider:PR) -> Module {
        let module = Module(provider: provider)
        
        module.presenter.view = module.view as? PR.P.V
        module.view.presenter = module.presenter as? PR.V.P
        module.presenter.interactor = module.interactor as? PR.P.I
        module.presenter.router = module.router as? PR.P.W
        module.interactor.presenter = module.presenter as? PR.I.P
        module.router.view = module.view as? PR.R.V
        return module
    }
    
    func presentModule(module:PR) {
        self.view.show(module.view)
    }
}

extension View {
    
    func show(_ vc: Self) {
        print("Show on extension not implemented.")
    }
    
    static func instantiateView()-> Self? {
        print("Show on extension not implemented.")
        return nil
    }
}

enum ViewPresenterType {
    case view(UIViewController,embeded: Bool, modal: Bool , transitionDelegate: UIViewControllerTransitioningDelegate?)
    case window(UIWindow,embeded: Bool)
}

extension Module where PR.V: UIViewController {
    
    func show(in viewPresenter:ViewPresenterType) {
        
        switch viewPresenter {
        case .view(let vc, let embeded, let modal, let transitionDelegate):
            if embeded {
                if let navigationController = UINavigationController.instantiateView(storyboard:ResourceKey.Storyboard.main.rawValue, identifier:ResourceKey.View.mainNavigationController.rawValue ) as? UINavigationController {
                    navigationController.viewControllers = [view]
                    if let transitionDelegate = transitionDelegate {
                        navigationController.transitioningDelegate = transitionDelegate
                        navigationController.modalPresentationStyle = .custom
                    }
                    
                    if modal {
                        vc.present(navigationController, animated: true, completion: nil)
                    } else {
                        vc.show(navigationController)
                    }
                } else {
                    self.show(in: vc, animated: true)
                }
            } else {
                self.show(in: vc, animated: true)
            }
        case .window(let window, let embeded):
            if embeded {
                if let navigationController = UINavigationController.instantiateView(storyboard:ResourceKey.Storyboard.main.rawValue, identifier:ResourceKey.View.mainNavigationController.rawValue ) as? UINavigationController {
                    navigationController.viewControllers = [view]
                    window.rootViewController = navigationController
                } else {
                    window.rootViewController = view
                }
            } else {
                window.rootViewController = view
            }
        }
        
        
    }
    
    func show(in vc:UIViewController, animated: Bool) {
        vc.present(view, animated: animated, completion: nil)
    }
}
