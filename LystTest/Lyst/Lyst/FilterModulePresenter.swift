//
//  FilterModulePresenter.swift
//  Lyst
//
//  Created by Samuel Hervás on 16/7/17.
//  Copyright © 2017 Sam Hervas. All rights reserved.
//

import Foundation

import LystProvider

protocol FilterModulePresenterProtocol: Presenter {
    
    weak var view: FilterModuleView?  { get set }
    var interactor: FilterModuleInteractor?  { get set }
    var router: FilterModuleRouter?  { get set }
    
    var product : String { get }
    var type : String {
        get
    }
    
    var category : String { get set }
    
    var gender: Gender { get set
    }
    
    
    var categories : [Category]? { get set }
    
    init(category: String, gender: Gender)
    
    func viewDidLoad()
    
    func viewWillAppear()
    
    func didTapCancelButton()
    
    func retrieveCategories()
    
    func changeCategorySelected()
    
}


class FilterModulePresenter: NSObject, FilterModulePresenterProtocol {
    
    weak var view: FilterModuleView?
    var interactor: FilterModuleInteractor?
    var router: FilterModuleRouter?
    
    let product = "Shoes"
    let type = "category"
    
    var category : String = "boots" {
        didSet {
            changeCategorySelected()
        }
    }
    
    var gender: Gender = .female {
        didSet {
            retrieveCategories()
        }
    }
    
    lazy var hud : HUD = { return HUD.init(container: self.view!.view, type: .image) }()
    
    var categories : [Category]?

    required init(category: String, gender: Gender) {
        self.category = category
        self.gender = gender
    }
    
}

extension FilterModulePresenterProtocol where Self: FilterModulePresenter {
    
    
    func viewDidLoad() {
        self.view?.view.addSubview(hud)
    }
    
    func viewWillAppear() {
        
        hud.show(true)
        self.view?.selectCell(gender: gender)
        retrieveCategories()
    }
    
    func didTapCancelButton() {
        self.view?.dismiss(animated: true, completion: nil)
    }
    
    func retrieveCategories() {
        self.interactor?.retrieveCategories(gender: gender, product: product, type: type) {  [weak self](result) in
            self?.hud.hide()
            switch result {
            case .success(let categories):
                self?.categories = categories
                self?.view?.categoriesPicker.reloadAllComponents()
                self?.changeCategorySelected()
            case .failure:
                print("Error: Loading Categories")
            }
        }
    }
    
    func changeCategorySelected() {
        guard let index = self.categories?.index(where: { (cat) -> Bool in
            return cat.value == category
        }) as Int? else {
            return
        }
        self.view?.categoriesPicker.selectRow(index, inComponent: 0, animated: false)
    }
}

extension FilterModulePresenter: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.categories?.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.categories?[row].name ?? ""
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
}
