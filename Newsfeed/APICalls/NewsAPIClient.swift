//
//  NewsAPIClient.swift
//  Newsfeed
//
//  Created by riya singhal on 21/07/22.
//

import Foundation
import FoxAPIKit

public typealias APICompletion<T> = (APIResult<T>) -> Void

class NewsAPIClient: APIClient<AuthHeaders, ErrorResponse> {
    
    static let shared = NewsAPIClient()
    
    override init() {
        super.init()
        #if DEBUG
        enableLogs = true
        #else
        enableLogs = false
        #endif
    }
    
    override func authenticationHeaders(response: HTTPURLResponse) -> AuthHeaders? {
        return nil
    }
    
}
