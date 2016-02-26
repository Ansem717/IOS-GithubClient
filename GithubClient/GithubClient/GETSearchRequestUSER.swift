//
//  GETSearchRequest.swift
//  GithubClient
//
//  Created by Andy Malik on 2/24/16.
//  Copyright © 2016 AndyMalik. All rights reserved.
//

import Foundation

class GETSearchRequestUSER: APIRequest {
    var httpMethod = HTTPMethod.GET
    var headerContentType = MIMEType.ApplicationJSON
    
     var searchResult: String
    init(searchResult: String){
        self.searchResult = searchResult
    }
    
    func url() -> String {
        return "https://api.github.com/search/users"
    }
    
    func queryStringParam() -> [String : String]? {
        return ["q": searchResult]
    }
}