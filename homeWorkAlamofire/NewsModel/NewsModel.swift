//
//  NewsModel.swift
//  homeWorkAlamofire
//
//  Created by Valeriia Zakharova on 26.01.2020.
//  Copyright © 2020 Valeriia Zakharova. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

//class NewsModel: Mappable {
class NewsModel {
    var status: String?
    var totalResults: Int?
    var articles: [NewsArticleModel]?
    
    //если status = nil, модель не прийдет
//    required init?(map: Map) {
//        do {
//            status = try map.value("status")
//        } catch {
//            debugPrint("Failed while map 'status'")
//        }
//
//    }
    
//    func mapping(map: Map) {
//        status          <- map["status"]
//        totalResults    <- map["totalResults"]
//        articles        <- map["articles"]
//    }
    
}

//class NewsArticleModel: Mappable {
class NewsArticleModel {
    
//    var source: NewsArticleSourceModel?
    var author: String?
    var title: String?
    var description: String?
    var url: String?
    var urlToImage: String?
    var publishedAt: String?
    var content: String?
    

    
    func date() -> Date? {
        let formatter = ISO8601DateFormatter()
        guard let published = publishedAt else {
            return nil
        }
        return formatter.date(from: published)
    }
    
    func titleSort() {
    
        guard let title = title else {
            return
        }
    }
    
   
    
//    required init?(map: Map) {
//
//    }
    
//    func mapping(map: Map) {
//
//        author          <- map["source"]
//        author          <- map["author"]
//        title           <- map["title"]
//        description     <- map["description"]
//        url             <- map["url"]
//        urlToImage      <- map["urlToImage"]
//        publishedAt     <- map["publishedAt"]
//        content         <- map["content"]
//    }
}

//class NewsArticleSourceModel: Mappable {
//
//    var id: String?
//    var name: String?
//
//
//    required init?(map: Map) {
//
//    }
//
//    func mapping(map: Map) {
//
//        id     <- map["id"]
//        name   <- map["name"]
//    }
//
//}
