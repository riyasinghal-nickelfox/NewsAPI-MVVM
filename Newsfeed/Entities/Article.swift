//
//  Article.swift
//  Newsfeed
//
//  Created by riya singhal on 21/07/22.
//

import Foundation
import JSONParsing

final public class Article{
    
    init(author: String?, title: String?, publisher: String?, urlToImage: String? = nil, description: String?, publishedAt: Date?) {
        self.author = author
        self.title = title
        self.publisher = publisher
        self.urlToImage = urlToImage
        self.description = description
        self.publishedAt = publishedAt
    }
    
    public var author : String?
    public var title: String?
    public var publisher: String?
    public var urlToImage: String?
    public var description: String?
    public var publishedAt: Date?
}

extension Article: JSONParseable {
    
    public static func parse(_ json: JSON) throws -> Article {
        return try Article(author: json["author"]^?, title: json["title"]^?, publisher: json["publisher"]^?, urlToImage: json["urlToImage"]^?, description: json["description"]^?,
                           publishedAt: Date.transform(json["publishedAt"]^))
    }
    
}


extension Date: JSONParseTransformable {
    
    public typealias RawValue = String
    
    public static func transform(_ value: String) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-ddEEEEEHH:mm:ssZ"
        return formatter.date(from: value)
    }
}
