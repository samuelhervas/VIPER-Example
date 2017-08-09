//
//  FilterModuleView.swift
//  Lyst
//
//  Created by Samuel Hervás on 16/7/17.
//  Copyright © 2017 Sam Hervas. All rights reserved.
//

import Foundation

import LystProvider

class FilterModuleView: UITableViewController, View {
    
    var presenter: FilterModulePresenter?
    
    @IBOutlet var maleFilter: UITableViewCell!
    @IBOutlet var femaleFilter: UITableViewCell!
    @IBOutlet var categoriesPicker: UIPickerView!
    
    weak var filterDelegate: FilterDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        categoriesPicker.delegate = self.presenter
        categoriesPicker.dataSource = self.presenter
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.viewWillAppear()
    }
    
    @IBAction func didTapCancelButton(_ sender: Any) {
        self.presenter?.didTapCancelButton()
    }
    
    @IBAction func didTapApplyButton(_ sender: Any) {
        guard let presenter = presenter, let category = self.presenter?.categories?[self.categoriesPicker.selectedRow(inComponent: 0)] else {
            return
        }
        self.filterDelegate?.didSelect(gender: presenter.gender, category: category.value)
        self.presenter?.didTapCancelButton()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if cell == maleFilter {
            self.selectCell(gender: .male)
        } else {
            self.selectCell(gender: .female)
        }
    }
    
    func selectCell(gender:Gender) {
        if gender == .male {
            maleFilter.accessoryType = .checkmark
            femaleFilter.accessoryType = .none
        } else {
            maleFilter.accessoryType = .none
            femaleFilter.accessoryType = .checkmark
        }
        self.presenter?.gender = gender
        self.categoriesPicker.selectRow(0, inComponent: 0, animated: true)
    }
    
}
