//
//  NewsListViewController.swift
//  homeWorkAlamofire
//
//  Created by Valeriia Zakharova on 25.01.2020.
//  Copyright © 2020 Valeriia Zakharova. All rights reserved.
//

import UIKit

class NewsListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    /// this collection is responsible for expanded/collapsed state of cells
    var expandedIndexPaths: Set<IndexPath> = []
    
    var articles: [NewsArticleModel] = []
    
    var filterByDate = FilterByDate.none
    var filterByTitle = FilterByTitle.none
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "NewsCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
        
        let button = UIBarButtonItem(title: "Sorted", style: .plain, target: self, action: #selector(sortButtonTapped(_:)))
        navigationItem.rightBarButtonItem = button
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        sortArticels()
        tableView.reloadData()
        
    }
    
    @objc
    func sortButtonTapped(_ sender: UIBarButtonItem) {
        let storyboardMain = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboardMain.instantiateViewController(identifier: "SortViewController") as! SortViewController
        
        vc.filterByDate = filterByDate
        vc.filterByTitle = filterByTitle
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension NewsListViewController: NewsCellDelegate {
    func didTapToggle(cell: NewsCell) {
        
        guard let indexPath = tableView.indexPath(for: cell) else {
            print("I don't know when it can happen")
            return
        }
        if expandedIndexPaths.contains(indexPath) {
            expandedIndexPaths.remove(indexPath)
            cell.updateCell(model: articles[indexPath.row], isExpanded: false)
        } else {
            expandedIndexPaths.insert(indexPath)
            cell.updateCell(model: articles[indexPath.row], isExpanded: true)
        }
        
        cell.setNeedsLayout()
        tableView.beginUpdates()
        tableView.endUpdates()
    }
}

extension NewsListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as! NewsCell
        cell.delegate = self
        let isExpanded = expandedIndexPaths.contains(indexPath)
        cell.updateCell(model: articles[indexPath.row], isExpanded: isExpanded)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboardMain = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboardMain.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
        
        vc.urlData = articles[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension NewsListViewController {
    
    func sortArticels() {
        
        articles = articles.sorted(by: { lhs, rhs -> Bool in
            if filterByDate == .none {
                return true
            } else {
                guard let leftDate = lhs.date(), let rightDate = rhs.date() else {
                    return false
                }
                return leftDate > rightDate
            }
        })
        
        articles = articles.sorted(by: { s1, s2 -> Bool in
            if filterByTitle == .none {
                return true
            } else {
                guard let aTitle = s1.title, let bTitle = s2.title else {
                    return false
                }
                return aTitle < bTitle
            }
            
        })
    }
}

