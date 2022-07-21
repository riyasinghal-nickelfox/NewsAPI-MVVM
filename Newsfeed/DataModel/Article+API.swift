//
//  Article+API.swift
//  Newsfeed
//
//  Created by riya singhal on 21/07/22.
//

import Foundation
import ReactiveSwift
import FoxAPIKit

extension Article {
    
    public static func fetch(params:[String:Any]) -> SignalProducer<[Article], ModelError>{
        return SignalProducer.init { observer, lifetime in
            let router = NewsRouter.fetchNews(params)
            NewsAPIClient.shared.request(router) { (result : APIResult<ListResponse<Article>>) in
                switch result {
                case .success(let value):
                    let articles : [Article] = value.list
                    print(articles, "Articles")
                    observer.send(value: articles)
                    observer.sendCompleted()
                case .failure(let error):
                    observer.send(error: ModelError.custom(message: error.message))
                }
            }
            
        }
        
    }
    
}

