//
//  SplashModule.swift
//  
//
//  Created by Samuel Hervás on 7/7/17.
//  Copyright © 2017 Sam Hervas. All rights reserved.
//

import UIKit


class SplashModule: ModuleProvider {
    
    var presenter: SplashPresenter {
        return SplashPresenter()
    }
    
    var view: SplashView {
        return SplashView.instantiateView(storyboard: ResourceKey.Storyboard.main.rawValue, identifier: ResourceKey.View.splash.rawValue) as! SplashView
    }
    
    var router: SplashRouter {
        return SplashRouter()
    }
    
    var interactor: SplashInteractor {
        return SplashInteractor()
    }
    
    required init() {
        
    }
}


class SplashPresenter: Presenter {
    
    weak var view: SplashView?
    var interactor: SplashInteractor?
    var router: SplashRouter?
    
    func viewDidLoad() {
        
    }
    func viewDidAppear() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {
            self.view?.dismiss(animated: true, completion: nil)
        })
    }
}

class SplashView: UIViewController, View {
    
    var presenter: SplashPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.viewDidAppear()
    }
}

class SplashInteractor: Interactor {
    
    weak var presenter: SplashPresenter?
    
    
    init() {
        
    }
    
}

class SplashRouter: Router {
    
    weak var view: SplashView?

}

