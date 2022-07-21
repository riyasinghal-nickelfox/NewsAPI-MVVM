//
//  APIConfig.swift
//  Newsfeed
//
//  Created by riya singhal on 21/07/22.
//

import Foundation
public struct APIConfig {
    
    
    
    public struct APIUrl {
        
        #if DEBUG
        static let domain = APIUrl.dev
        #elseif DEV
        static let domain = APIUrl.qa
        #elseif STAGING
        static let domain = APIUrl.staging
        #elseif RELEASE
        static let domain = APIUrl.prod
        #endif
        private static let dev = "https://newsapi.org/v2/everything"
        private static let qa = "https://newsapi.org/v2/everything"
        private static let staging = "https://newsapi.org/v2/everything"
        private static let prod = "https://newsapi.org/v2/everything"
    }
        

    }

