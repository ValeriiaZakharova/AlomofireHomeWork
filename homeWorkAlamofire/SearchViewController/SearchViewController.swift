//
//  ViewController.swift
//  homeWorkAlamofire
//
//  Created by Valeriia Zakharova on 25.01.2020.
//  Copyright © 2020 Valeriia Zakharova. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    @IBOutlet weak var newsLable: UILabel!
    @IBOutlet weak var textToSearchTextField: UITextField!
    @IBOutlet weak var dateFromTextField: UITextField!
    @IBOutlet weak var dateToTextfield: UITextField!
    
    @IBOutlet weak var bottomConstScrollView: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let keyboardhide = UITapGestureRecognizer(target: self, action: #selector(keyboardWillHide))
        view.addGestureRecognizer(keyboardhide)
        
        textToSearchTextField.delegate = self
        dateFromTextField.delegate = self
        dateToTextfield.delegate = self
        
    }
    
    @IBAction func didTapSearchNews(_ sender: Any) {
        getNews(completion: { mainModel in
            guard let mainModel = mainModel else {
                // SHOW ALERT WITH ERROR
                
                let alert = UIAlertController(title: "Sorry, something went wrong", message: "Please press cancel", preferredStyle: .alert)
                let close = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(close)
                self.present(alert, animated: true, completion: nil)
                
                return
            }
            
            // show news list with fetched articles
            guard let articles = mainModel.articles else {
                
                let alert = UIAlertController(title: "Hey, sorry", message: "There is no result, please try again", preferredStyle: .alert)
                let close = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                alert.addAction(close)
                self.present(alert, animated: true, completion: nil)
                return
            }
            
            print("\(articles.count) aricles received")
            self.showNewsList(articles: articles)
        })
    }
    
    func showNewsList(articles: [NewsArticleModel]) {
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = mainStoryboard.instantiateViewController(identifier: "NewsListViewController") as! NewsListViewController
        viewController.articles = articles
        navigationController?.pushViewController(viewController, animated: true)
    }
    
}

