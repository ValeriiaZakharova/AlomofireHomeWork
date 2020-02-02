//
//  HintforMe.swift
//  homeWorkAlamofire
//
//  Created by Valeriia Zakharova on 26.01.2020.
//  Copyright © 2020 Valeriia Zakharova. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AlamofireObjectMapper

extension SearchViewController {
    
    func getNewsMyHint() {
        
        guard let searchText = textToSearchTextField.text else {
            return
        }
        
        // must have key, to get access to server
        let apiKey = "dcf98ee62fa84cb1a032d16c0179e2e2"
        
        // optional query
        let from = dateFromTextField.text
        let to = dateToTextfield.text
        
        
        let url = "https://newsapi.org/v2/everything"
        var params = ["q": searchText]
        
        if let from = from, from.count > 0 {
            params["from"] = from
        }
        
        if let to = to, to.count > 0 {
            params["to"] = to
        }
                      
        
        let request = AF.request(url,
                                 method: HTTPMethod.get,
                                 parameters: params,
                                 encoding: URLEncoding.default,
                                 headers: ["X-Api-Key": apiKey],
                                 interceptor: nil)
        
        request.response(completionHandler: { response in
            if let data = response.data {
//                let string = String(data: data, encoding: .utf8)!
                do {
                    let jsonInfo = try JSONSerialization.jsonObject(with: data, options: [])
                    
                    guard let info = jsonInfo as? [String: Any] else {
                        print("ERROR")
                        return
                    }
                    
                    var articles: [NewsArticleModel] = []
                    if let articlesInfo = info["articles"] as? [[String: Any]] {
                        for articleInfo in articlesInfo {
                            let model = NewsArticleModel()
                            model.author = articleInfo["author"] as? String
                            model.title = articleInfo["title"] as? String
                            model.description = articleInfo["description"] as? String
                            model.url = articleInfo["url"] as? String
                            
                            articles.append(model)
                        }
                    }
                    
                    let mainModel = NewsModel()
                    mainModel.articles = articles
                    mainModel.status = info["status"] as? String
                    mainModel.totalResults = info["totalResults"] as? Int
                    
                    print(mainModel)
                    print(mainModel)
                    
                } catch {
                    print(error)
                }
            }
        })
        
        print(request)
        
    }
}

