//
//  SortViewController.swift
//  homeWorkAlamofire
//
//  Created by Valeriia Zakharova on 25.01.2020.
//  Copyright © 2020 Valeriia Zakharova. All rights reserved.
//

import UIKit

enum FilterByDate {
    case date
    case none
    
}

enum FilterByTitle{
    case title
    case none
}

class SortViewController: UIViewController {
    
    @IBOutlet weak var titleButton: UIButton!
    @IBOutlet weak var dateButton: UIButton!
    
    var filterByDate = FilterByDate.none
    var filterByTitle = FilterByTitle.none
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func didTapSortByTitle(_ sender: Any) {
        if filterByTitle == .title {
            filterByTitle = .none
        } else {
            filterByTitle = .title
        }
        updateTitleUI()
        
        if let navigationcontrollers = navigationController?.viewControllers {
            if let newsVc = navigationcontrollers[navigationcontrollers.count - 2] as? NewsListViewController {
                newsVc.filterByTitle = filterByTitle
                
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didTapSortByDate(_ sender: Any) {
        if filterByDate == .date {
            filterByDate = .none
        } else {
            filterByDate = .date
        }
        updateDateUI()
        if let navigationcontrollers = navigationController?.viewControllers {
            if let newsVc = navigationcontrollers[navigationcontrollers.count - 2] as? NewsListViewController {
                newsVc.filterByDate = filterByDate
                
            }
        }
        navigationController?.popViewController(animated: true)
        
    }
    
    func updateDateUI() {
        dateButton.isSelected = filterByDate == .date
    }
    
    func updateTitleUI() {
        titleButton.isSelected = filterByTitle == .title
    }
    
}
