//
//  BaseRouter.swift
//  Newsfeed
//
//  Created by riya singhal on 21/07/22.
//

import Foundation
import Foundation
import FoxAPIKit

public protocol BaseRouter : Router{
    
   }
   public let defaultPage = 10
   extension BaseRouter
   {
   public var method :HTTPMethod{
        return.get
    }
    public var path : String{
        return""
    }
    public var params: [String:Any]{
        return[:]
    }
       // use Api url
       public var baseUrl: URL
       {
           return URL(string: APIConfig.APIUrl.domain)!
       }
       public var headers: [String : String] {
           return ["Content-Type": "application/json"]
       }
       public var encoding: URLEncoding? {
           return nil
       }
       
       public var timeoutInterval: TimeInterval? {
           return nil
       }
       
       public var keypathToMap: String? {
           return nil
       }
    
}
